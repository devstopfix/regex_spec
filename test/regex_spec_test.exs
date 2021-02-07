defmodule RegexSpecTest do
  use ExUnit.Case

  alias Regex.Spec.DocCD
  alias Regex.Spec.EmptyCapture
  alias Regex.Spec.Matryoshka
  alias Regex.Spec.MaybePositiveInteger
  alias Regex.Spec.PositiveInteger

  describe "Empty capture" do
    test "regex pattern is accessible" do
      assert EmptyCapture.regex() == ~r/()/
    end

    test "with empty string is false" do
      input = ""
      assert EmptyCapture.match?(input)
      assert ["", ""] == EmptyCapture.run(input)
    end

    test "with character is false" do
      input = "0"
      assert EmptyCapture.match?(input)
      assert ["", ""] == EmptyCapture.run(input)
    end
  end

  describe "Maybe positive integer" do
    test "with empty string is false and empty" do
      input = ""
      assert MaybePositiveInteger.match?(input)
      assert [""] == MaybePositiveInteger.run(input)
    end

    test "with character is false" do
      input = "a"
      assert MaybePositiveInteger.match?(input)
      assert [""] == MaybePositiveInteger.run(input)
    end

    test "with digit is true" do
      input = "0"
      assert MaybePositiveInteger.match?(input)
      assert ["0", "0"] == MaybePositiveInteger.run(input)
    end

    test "with digits is true" do
      input = "10"
      assert MaybePositiveInteger.match?("10")
      assert ["10", "10"] == MaybePositiveInteger.run(input)
    end
  end

  describe "Positive integer" do
    test "with empty string is false and nil" do
      input = ""
      refute PositiveInteger.match?(input)
      assert nil == PositiveInteger.run(input)
    end

    test "with char is false and nil" do
      input = "a"
      refute PositiveInteger.match?(input)
      assert nil == PositiveInteger.run(input)
    end

    test "with digits is true" do
      input = "0"
      assert PositiveInteger.match?(input)
      assert ["0", "0"] == PositiveInteger.run(input)
      assert [{0, 1}, {0, 1}] == PositiveInteger.run_indicies(input)
    end

    test "with digit and char is true" do
      input = "x0"
      assert PositiveInteger.match?(input)
      assert ["0", "0"] == PositiveInteger.run(input)
      assert [{1, 1}, {1, 1}] == PositiveInteger.run_indicies(input)
    end
  end

  describe "c maybe d" do
    test "abcd" do
      input = "abcd"
      assert DocCD.match?(input)
      assert ["cd", "d"] == DocCD.run(input)
      assert [{2, 2}, {3, 1}] == DocCD.run_indicies(input)
    end
  end

  describe "Nested captures" do
    test "xabcx" do
      input = "xabcx"
      assert Matryoshka.match?(input)
      assert ["abc", "abc", "bc", "c"] == Matryoshka.run(input)
      assert [{1, 3}, {1, 3}, {2, 2}, {3, 1}] == Matryoshka.run_indicies(input)
    end

    test "spec" do
      assert ["abc", "abc", "bc", "c"] == Regex.Verify.Matryoshka.run("abc")
    end
  end
end
