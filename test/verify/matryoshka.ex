defmodule Regex.Verify.Matryoshka do
  @moduledoc "Verify spec of Matryoshka regex"

  alias Regex.Spec.Matryoshka

  @spec run(binary) :: nil | [String.t()]
  def run(s), do: Matryoshka.run(s)

  @spec runt(binary) :: nil | {Map.t(), String.t(), String.t(), String.t()}
  def runt(s), do: Matryoshka.runt(s)
end
