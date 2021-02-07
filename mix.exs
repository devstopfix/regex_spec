defmodule RegexSpec.MixProject do
  use Mix.Project

  def project,
    do: [
      app: :regex_spec,
      version: "0.21.38",
      description: "Generated type specifications for regualar expressions at compile time",
      elixir: "~> 1.10",
      elixirc_paths: elixirc_paths(Mix.env()),
      deps: deps(),
      docs: docs(),
      package: package(),
      start_permanent: Mix.env() == :prod
    ]

  def application,
    do: [
      extra_applications: [:logger]
    ]

  defp deps,
    do: [
      {:credo, "~> 1.5", only: [:dev, :test], runtime: false},
      {:dialyxir, "~> 1.0", only: [:dev], runtime: false},
      {:ex_doc, "~> 0.23", only: [:dev], runtime: false}
    ]

  defp docs,
    do: [
      main: "Regex.Spec",
      extra: ["README.md"]
    ]

  defp package,
    do: [
      files: ["lib", "mix.exs", "README*", "LICENSE*"],
      maintainers: ["J Every"],
      licenses: ["MIT"],
      links: %{
        "GitHub" => "https://github.com/devstopfix/regex_spec"
      }
    ]

  # Compile verification paths during testing
  # to allow Dialyzer to verify the generated specs
  defp elixirc_paths(:test), do: ["lib", "test/specs", "test/verify"]
  defp elixirc_paths(_), do: ["lib"]
end
