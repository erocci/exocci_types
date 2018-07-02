defmodule OCCI.Types.String do
  @moduledoc """
  OCCI Type: String

  Options:
  * `match`: PCRE regexp

  Example:
  * `OCCI.Types.String`
  * `{OCCI.Types.String, match: "..."}`
  """
  use OCCI.Types

  def check_opts(opts) do
    try do
      case Keyword.get(opts, :match, nil) do
        nil ->
          true

        r when is_binary(r) ->
          {true,
           [
             match:
               quote do
                 Regex.compile!(unquote(r))
               end
           ]}

        _ ->
          false
      end
    rescue
      FunctionClauseError -> false
    end
  end

  def cast(v, opts \\ []) do
    case Keyword.get(opts, :match, nil) do
      nil ->
        try do
          "#{v}"
        rescue
          Protocol.UndefinedError ->
            "#{inspect(v)}"
        end

      r ->
        if Regex.match?(r, v) do
          v
        else
          raise OCCI.Types.Error, {422, "#{inspect(v)} does not match #{inspect(r)}"}
        end
    end
  end
end
