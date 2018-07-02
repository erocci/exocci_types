defmodule OCCI.Types.Kind do
  @moduledoc """
  OCCI type: Kind

  Example:
  * `{OCCI.Types.Kind, Model}`
  """
  use OCCI.Types

  def check_opts(model) when is_atom(model), do: true
  def check_opts(_), do: false

  def cast(v, model) do
    kind = :"#{v}"

    if model.kind?(kind) do
      kind
    else
      raise OCCI.Types.Error, {422, "Invalid kind: #{v}"}
    end
  end
end
