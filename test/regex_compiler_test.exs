defmodule RegexCompilerTest do
  use ExUnit.Case

  import Regex.Spec.Compiler, only: [parse_captures: 1]

  describe "Lists" do
    test "can be parsed" do
      {:ok, captures} = parse_captures("[:foo, [1], [:bar, [2, 3]]]")
      assert captures == [:foo, [1], [:bar, [2, 3]]]
    end
  end
end
