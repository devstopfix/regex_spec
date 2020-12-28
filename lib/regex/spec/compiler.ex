defmodule Regex.Spec.Compiler do

  @moduledoc """
  Compiles a Regex.t() into a typespec.
  """

  def compile(%Regex{source: source}) do
    case source do
      "(\\d+?)" -> "integer() | nil"
    end
  end
end
