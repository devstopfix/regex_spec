# Regex.Spec

Generates [type specifications][1] for [Regular Expressions][2] at compile time allowing Dialyzer to detect type errors.

This library generates the common [Regex][2] functions for your 
regular expression with a type spec. Create a module for your type
and use:

```elixir
defmodule MyApp do

  defmodule MMYYDDDD do
    use Regex.Spec, regex: ~r/(\d{2})\\(\d{2})\\(\d{4})/
  end

  IO.inspect(MMYYDDDD.matches?("2020-12-31")) # false

end
```

## Installation

Append to your `mix.exs deps`:

```elixir
    {:regex_spec, "~> 0.20.0"}
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at [https://hexdocs.pm/regex_spec](https://hexdocs.pm/regex_spec).

[1]: https://hexdocs.pm/elixir/typespecs.html
[2]: https://hexdocs.pm/elixir/Regex.html
