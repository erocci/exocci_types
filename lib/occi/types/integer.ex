defmodule OCCI.Types.Integer do
  @moduledoc """
  OCCI type: integer

  Options:
  * `min`
  * `max`

  Example:
  * `OCCI.Types.Integer`
  * `{OCCI.Types.Integer, min: 2, max: 45}`
  """
  use OCCI.Types

  def check_opts(_), do: true

  def cast(v, opts \\ nil)

  def cast(v, opts) when is_integer(v) do
    range(v, Keyword.get(opts, :min), Keyword.get(opts, :max))
  end

  def cast(v, opts) when is_binary(v) do
    case Integer.parse(v) do
      :error -> raise OCCI.Types.Error, {422, "Invalid integer: #{v}"}
      {i, ""} -> range(i, Keyword.get(opts, :min), Keyword.get(opts, :max))
      _ -> raise OCCI.Types.Error, {422, "Invalid integer: #{v}"}
    end
  end

  defp range(i, nil, nil), do: i
  defp range(i, min, nil) when i >= min, do: i
  defp range(i, nil, max) when i <= max, do: i
  defp range(i, min, max) when i >= min and i <= max, do: i

  defp range(i, min, max),
    do: raise(OCCI.Types.Error, {422, "Not in range(#{inspect(min)}, #{inspect(max)}): #{i}"})
end
