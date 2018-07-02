defmodule OcciTypes.MixProject do
  use Mix.Project

  def project do
    [
      app: :occi_types,
      version: "0.1.1",
      elixir: "~> 1.6",
      start_permanent: Mix.env() == :prod,
      aliases: [
        compile: ["format", "compile", "credo"]
      ],
      deps: deps(),
      name: "exocci.types",
      description: description(),
      package: package(),
      source_url: "https://github.com/erocci/exocci_types",
      homepage_url: "https://github.com/erocci/exocci_types",
      docs: docs()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:credo, "~> 0.9", only: [:dev, :test], runtime: false},
      {:ex_doc, ">= 0.0.0", only: :dev, runtime: false}
    ]
  end

  defp description do
    """
    OCCI types checker for exocci application.

    In a separate package as model compilation requires OCCI types at early stage
    """
  end

  defp package do
    [
      name: :occi_types,
      maintainers: ["Jean Parpaillon"],
      licenses: ["Apache 2.0"],
      links: %{
        "GitHub" => "https://github.com/erocci/exocci_types"
      }
    ]
  end

  defp docs do
    [
      main: "OCCI.Types",
      logo: "erocci-logo-only.png",
      source_url: "https://github.com/erocci/exocci_types"
    ]
  end
end
