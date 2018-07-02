defmodule OCCI.Types.Boolean do
  @moduledoc """
  OCCI type: boolean

  Example:
  * `OCCI.Types.Boolean`
  """
  use OCCI.Types

  def cast(v, _) when is_boolean(v), do: true

  def cast(v, _) do
    raise OCCI.Types.Error, {422, "Invalid boolean: #{inspect(v)}"}
  end
end
