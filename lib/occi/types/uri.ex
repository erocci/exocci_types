defmodule OCCI.Types.URI do
  @moduledoc """
  OCCI Type: URI

  Actually same as `OCCI.Types.String`
  """

  use OCCI.Types
  defdelegate cast(v), to: OCCI.Types.String
  defdelegate cast(v, opts), to: OCCI.Types.String
end
