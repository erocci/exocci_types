defmodule OCCI.Types.Mixin do
  @moduledoc """
  OCCI type: Mixin

  Example:
  * `{OCCI.Types.Mixin, Model}`
  """
  use OCCI.Types

  def check_opts(model) when is_atom(model), do: true
  def check_opts(_), do: false

  def cast(v, model) do
    mixin = :"#{v}"

    if model.mixin?(mixin) do
      mixin
    else
      raise OCCI.Types.Error, {422, "Invalid mixin: #{v}"}
    end
  end
end
