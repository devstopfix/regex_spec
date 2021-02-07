defmodule Regex.Spec.Compiler do
  @moduledoc false

  def compile(%Regex{source: source}) do
    case parse_captures(source) do
      {:ok, captures} -> captures_spec(captures)
    end
  end

  @doc """
  Lex and parse a regex into a list of captures.
  """
  @spec parse_captures(String.t()) :: {:ok, list(tuple())} | {:error, term(), integer()}
  def parse_captures(re) do
    s = to_charlist(re)

    case :pcre_tokens.string(s) do
      {:ok, tokens, _} ->
        case :pcre_captures.parse(tokens) do
          {:ok, result} -> {:ok, result}
          {:error, error} -> {:error, error, 0}
        end

      {:error, e, l} ->
        {:error, e, l}
    end
  end

  @spec captures_spec(list(tuple())) :: String.t()
  def captures_spec(captures) do
    captures
    |> walk()
    |> tuple_spec()
  end

  defp tuple_spec(captures), do:
    captures
    |> Enum.map(fn _ -> "String.t()" end)
    |> Enum.intersperse(", ")
    |> wrap_tuple()
    |> to_string()

  # Depth-first, pre-order walk of the tree to list of captures
  defp walk([]), do: []
  defp walk([x | xs]), do: [walk(x) | walk(xs)]
  defp walk(%{:capture => []} = x), do: [flat(x)]
  defp walk(%{:capture => xs} = x), do: [flat(x) | walk(xs)]

  defp flat(x), do: Map.delete(x, :capture)

  defp wrap_tuple(s), do: ["{", s, "}"]
end
