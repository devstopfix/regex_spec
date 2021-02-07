# Regex.Spec

Generates [type specifications][1] for [Regular Expressions][2] at compile time allowing Dialyzer to detect type errors.

This library generates the common [Regex][2] functions for your 
regular expression with a type spec. Create a module for your type
and use:

```elixir
defmodule MyApp do

  defmodule MMYYDDDD do
    use Regex.Spec, regex: ~r/(\d{2})\-(\d{2})\-(\d{4})/
  end

  IO.inspect(MMYYDDDD.matches?("2020-12-31")) # false
  IO.inspect(MMYYDDDD.run("12-31-2020")) # ["12-31-2020", "12", "31", "2020"]
  IO.inspect(MMYYDDDD.runt("12-31-2020")) # {"12-31-2020", "12", "31", "2020"}

end
```

The specification for [run/3][run] is a list of Strings, and we cannot specify a 
[dependent type such as a list of length 4][dep]. Therefore we implement the 
normal `run` function and also `runt` which can be read as *run typed* or *run tuple*
which returns a typed tuple.

## Installation

Append to your `mix.exs deps`:

```elixir
    {:regex_spec, "~> 0.21.0"}
```

## Design

This library uses [leex][leex] and [yecc][yecc] to compile your regular expression into a tree of capture groups and then into a Dialyzer tuple type specification.


The docs can be found at [https://hexdocs.pm/regex_spec](https://hexdocs.pm/regex_spec).

[1]: https://hexdocs.pm/elixir/typespecs.html
[2]: https://hexdocs.pm/elixir/Regex.html
[leex]: https://erlang.org/doc/man/leex.html
[yecc]: https://erlang.org/doc/man/yecc.html
[run]: https://hexdocs.pm/elixir/Regex.html#run/3
[dep]: https://en.wikipedia.org/wiki/Dependent_type