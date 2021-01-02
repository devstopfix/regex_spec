defmodule RegexSpecTest do
  use ExUnit.Case

  alias Regex.Spec.MaybePositiveInteger

  describe "Maybe positive integer" do
    test "with empty string is false" do
      refute MaybePositiveInteger.match?("")
    end

    test "with character is false" do
      refute MaybePositiveInteger.match?("a")
    end

    test "with digit is true" do
      assert MaybePositiveInteger.match?("0")
    end

    test "with digits is true" do
      assert MaybePositiveInteger.match?("10")
    end
  end
end
