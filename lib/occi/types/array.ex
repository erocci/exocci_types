defmodule OCCI.Types.Array do
  @moduledoc """
  OCCI type: (eventually typed) array

  Options:
  * `type`: the type of each element

  Example:
  * `OCCI.Types.Array`
  * `{OCCI.Types.Array, type: {OCCI.Types.Integer, min: 4}}`
  """
  use OCCI.Types

  def cast(arr, opts) when is_list(arr) do
    case Keyword.get(:type, opts, nil) do
      nil ->
        arr

      type ->
        {mod, opts} = OCCI.Types.check(type)
        Enum.map(arr, &mod.cast(&1, opts))
    end
  end
end
