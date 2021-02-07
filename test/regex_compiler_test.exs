defmodule RegexCompilerTest do
  use ExUnit.Case

  import Regex.Spec.Compiler, only: [parse_captures: 1, captures_spec: 1]

  describe "Regex without captures" do
    test "no expression returns empty list" do
      assert_re("", [])
    end

    test "no captures returns empty list" do
      assert_re("aaa", [])
    end
  end

  describe "Escaped captures" do
    test "are ignored" do
      assert_re("\\(\\)", [])
    end
  end

  describe "Linear captures" do
    test "empty capture" do
      re = "()"
      assert_re(re, [%{:capture => []}])
      assert_re_spec(re, "{String.t()}")
    end

    test "single digit int" do
      assert_re("(\\d)", [%{:capture => []}])
    end

    test "multiple digit int" do
      assert_re("(\\d+)", [%{:capture => []}])
    end

    test "strip leading zeros" do
      assert_re("0+(\\d)", [%{:capture => []}])
    end

    test "double digits" do
      re = "(1)(2)"
      assert_re(re, [%{:capture => []}, %{:capture => []}])
      assert_re_spec(re, "{String.t(), String.t()}")
    end
  end

  describe "Nested captures" do
    test "one deep" do
      assert_re("(())", [%{:capture => [%{:capture => []}]}])
    end

    test "two deep" do
      assert_re("((()))", [%{:capture => [%{:capture => [%{:capture => []}]}]}])
    end

    test "two deep of two" do
      assert_re("((()()))", [
        %{:capture => [%{:capture => [%{:capture => []}, %{:capture => []}]}]}
      ])
    end
  end

  describe "Optional captures" do
    test "Flat with two trailing optional" do
      assert_re("(a)(b)?(c)?", [
        %{capture: []},
        %{capture: [], optional: true},
        %{capture: [], optional: true}
      ])
    end
  end

  defp assert_re(re, expected) do
    assert {:ok, expected} == parse_captures(re)
  end

  defp assert_re_spec(re, expected) do
    {:ok, captures} = parse_captures(re)
    assert expected == captures_spec(captures)
  end
end
