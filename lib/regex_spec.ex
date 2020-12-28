defmodule Regex.Spec do
  @moduledoc """
  For use in your module to define the return type
  of your regular expression.
  """

  alias Regex.Spec.Compiler

  @doc false
  defmacro __using__([regex: re]) do

    {:sigil_r, _, [{:<<>>, _, [re_s]}, []]} = re
    type = %Regex{source: re_s} |> Compiler.compile() |> Code.string_to_quoted!()

    quote do

      @type t() :: unquote(type)

      @doc """
      Returns a boolean indicating whether there was a match or not.
      See Regex.match?/2
      """
      @spec match?(String.t()) :: bool
      def match?(s) do
        Regex.match?(unquote(re), s)
      end
    end

  end

end
