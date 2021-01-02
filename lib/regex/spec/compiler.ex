defmodule Regex.Spec.Compiler do
  @moduledoc """
  Compiles a Regex.t() into a typespec.
  """

  def compile(%Regex{source: source}) do
    case source do
      "(\\d+?)" -> "integer() | nil"
    end
  end

  @doc """
  Lex and parse a regex into a tree of captures.
  """
  @spec parse_captures(String.t()) :: {:ok, tuple()} | {:error, term(), integer()}
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
end
