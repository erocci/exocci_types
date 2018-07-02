defmodule OCCI.Types do
  @moduledoc """
  Behaviour for OCCI attributes types.

  Attribute types are used to check and cast input value.

  When declaring an attribute, you must declare its type:
  ```
  attribute "my.type",
    type: OCCI.Types.Integer
  ```

  Options can be given to the application
  ```
  attribute "my.type",
    type: {OCCI.Types.Integer, min: 32}
  ```

  Enumerations are declared as simply as:
  ```
  attribute "my.type",
    type: [:value1, :value2]
  ```
  """

  @doc false
  defmacro __using__(_opts) do
    quote do
      @behaviour OCCI.Types

      def check_opts(_opts), do: true

      defoverridable check_opts: 1
    end
  end

  @callback check_opts(opts :: any) :: boolean | {true, canonical_opts :: any}
  @callback cast(data :: any, opts :: term) :: any

  @doc """
  Return {module, opts}
  """
  def check(type) when is_list(type) do
    {OCCI.Types.Enum, type}
  end

  def check({mod, opts}) do
    case Code.ensure_loaded(mod) do
      {:module, _} ->
        if function_exported?(mod, :cast, 1) || function_exported?(mod, :cast, 2) do
          case mod.check_opts(opts) do
            false -> raise OCCI.Types.Error, {422, "Invalid options for #{mod}: #{inspect(opts)}"}
            true -> {mod, opts}
            {true, opts} -> {mod, opts}
          end
        else
          raise OCCI.Types.Error, {422, "#{mod} do not implements OCCI.Types behaviour"}
        end

      _ ->
        raise OCCI.Types.Error, {422, "You should require #{mod} before using it"}
    end
  end

  def check(mod) when is_atom(mod) do
    check({mod, []})
  end

  @doc false
  def __requires__(type) when is_list(type), do: [OCCI.Types.Enum]
  def __requires__({mod, _}), do: [mod]
  def __requires__(mod) when is_atom(mod), do: [mod]
end
