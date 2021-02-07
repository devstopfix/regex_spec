defmodule Regex.Spec.Matryoshka do
  @moduledoc "Nested captures"

  use Regex.Spec, regex: ~r/(a(b(c)))/
end
