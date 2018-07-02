defmodule OCCI.Types.Float do
  @moduledoc """
  OCCI type: float

  Example:
  * `OCCI.Types.Float`
  """
  use OCCI.Types

  def cast(v, opts \\ nil)

  def cast(v, _) when is_float(v) do
    v
  end

  def cast(v, _) when is_binary(v) do
    case Float.parse(v) do
      :error -> raise OCCI.Types.Error, {422, "Invalid float: #{v}"}
      {i, ""} -> i
      _ -> raise OCCI.Types.Error, {422, "Invalid float: #{v}"}
    end
  end
end
