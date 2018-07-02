defmodule OCCI.Types.Enum do
  @moduledoc """
  OCCI type: enumeration

  Example:
  * `{OCCI.Types.Enum, [:value1, :value2]}`
  * `[:value1, :value2]`
  """
  use OCCI.Types

  def check_opts(values) when is_list(values), do: true
  def check_opts(_), do: false

  def cast(v, values) do
    val = :"#{v}"

    if val in values do
      val
    else
      raise OCCI.Types.Error, {422, "Invalid value: #{v} not in #{inspect(values)}"}
    end
  end
end
