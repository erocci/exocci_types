defmodule OCCI.Types.CIDR do
  @moduledoc """
  OCCI type: CIDR

  Values are casted to:
  `{:inet.ip_address(), netmask :: integer}`
  """
  use OCCI.Types

  def cast(v, _ \\ nil) do
    try do
      v
      |> parse_cidr()
      |> cast_cidr()
    rescue
      _exc ->
        stacktrace = System.stacktrace()
        reraise OCCI.Types.Error, {422, "Invalid CIDR: #{inspect(v)}"}, stacktrace
    end
  end

  defp parse_cidr(v) do
    case String.split("#{v}", "/") do
      [addr] ->
        parse_address(addr)

      [addr, netmask] ->
        parse_range(addr, netmask)
    end
  end

  defp parse_address(addr) do
    case :inet.parse_address('#{addr}') do
      {:ok, cidr} when tuple_size(cidr) == 4 -> {cidr, 32}
      {:ok, cidr} when tuple_size(cidr) == 8 -> {cidr, 128}
      _ -> raise ""
    end
  end

  defp parse_range(addr, netmask) do
    case :inet.parse_address('#{addr}') do
      {:ok, cidr} when tuple_size(cidr) == 4 ->
        {cidr, OCCI.Types.Integer.cast(netmask, min: 0, max: 32)}

      {:ok, cidr} when tuple_size(cidr) == 8 ->
        {cidr, OCCI.Types.Integer.cast(netmask, min: 0, max: 128)}

      _ ->
        raise ""
    end
  end

  defp cast_cidr({cidr, mask}), do: "#{:inet.ntoa(cidr)}/#{mask}"
end
