defmodule Regex.Spec do
  @moduledoc """
  Provides typed regular expressions for your Elixir application.

  Use in your module to define the return type of your regular expression functions.
  """

  alias Regex.Spec.Compiler

  @doc false
  defmacro __using__(regex: regex) do
    {:sigil_r, _, [{:<<>>, _, [source]}, []]} = regex
    type = %Regex{source: source} |> Compiler.compile() |> Code.string_to_quoted!()

    quote do
      @type t() :: unquote(type)

      @doc false
      @spec match?(binary()) :: bool
      def match?(s) do
        Regex.match?(unquote(regex), s)
      end

      @doc false
      @spec regex() :: Regex.t()
      def regex, do: unquote(regex)

      @doc false
      @spec run(binary()) :: nil | [String.t()]
      def run(s) do
        Regex.run(unquote(regex), s)
      end

      @doc false
      @spec runt(binary()) :: nil | t()
      def runt(s) do
        Regex.run(unquote(regex), s)
      end

      @doc false
      @spec run_indicies(binary()) :: nil | [{integer(), integer()}]
      def run_indicies(s) do
        Regex.run(unquote(regex), s, return: :index)
      end
    end
  end

  @doc """
  Returns a boolean indicating whether there was a match or not.

  See `Regex.match?/2`
  """
  @callback match?(s :: binary()) :: bool()

  @doc """
  The original compiled Regular Expression.
  """
  @callback regex() :: Regex.t()

  @doc """
  Runs the regular expression against the given string until the first match.
  It returns a list with all captures or nil if no match occurred.
  See `Regex.run/3`
  """
  @callback run(s :: binary()) :: nil | [String.t()]

  @doc """
  Runs the regular expression against the given string until the first match.
  It returns a list of byte index and match length or nil if no match occurred.
  See `Regex.run/3` with `[return: :index]` option.
  """
  @callback run_indicies(s :: binary()) :: nil | [{integer(), integer()}]
end
