defmodule Raw do
  def findValue([head | tail]) do
    minValues(tail, [head])
  end

  defp minValues([%{count: count} | tail], [%{count: min_count} | _tail] = main_head)
       when count > min_count do
    minValues(tail, main_head)
  end

  defp minValues([%{count: count} = head | tail], [%{count: min_count} | _tail])
       when count < min_count do
    minValues(tail, [head])
  end

  defp minValues([%{count: count} = head | tail], [%{count: min_count} | _tail] = main_head)
       when count == min_count do
    minValues(tail, [head | main_head])
  end

  defp minValues([], value), do: value

  def getmin(maplst, key) do
    m = maplst |> Enum.map(fn x -> Map.get(x, key) end) |> Enum.min()
    # Enum.filter(maplst, fn x -> Map.get(x, key) == m end)
  end
end

array = [
  %{count: 4, img: 1},
  %{count: 8, img: 2},
  %{count: 3, img: 3},
  %{count: 5, img: 4},
  %{count: 5, img: 1},
  %{count: 7, img: 2},
  %{count: 3, img: 3},
  %{count: 9, img: 4},
  %{count: 4, img: 1},
  %{count: 8, img: 2},
  %{count: 3, img: 3},
  %{count: 5, img: 4},
  %{count: 5, img: 1},
  %{count: 7, img: 2},
  %{count: 3, img: 3},
  %{count: 1, img: 4}
]

IO.inspect(Raw.findValue(array))
