defmodule Lister do
  def square([]), do: []
  def square([head | tail]), do: [head * head | square(tail)]

  def addNumber([], _), do: []
  def addNumber([head | tail], number), do: [head + number | addNumber(tail, number)]

  def mapper([], _), do: []
  def mapper([head | tail], func), do: [func.(head) | mapper(tail, func)]

  def reducer([], value, _), do: value

  def reducer([head | tail], value, func) do
    reducer(tail, func.(head, value), func)
  end

  def len([]), do: 0
  def len([_head | tail]), do: 1 + len(tail)

  def mapSum([], _func), do: 0
  def mapSum([head | tail], func), do: func.(head) + mapSum(tail, func)

  def maxValue([]), do: 0

  def maxValue([head | tail]) do
    result = maxValue(tail)

    if result > head do
      result
    else
      head
    end
  end

  # There is a simple hack for you.
  # :infinity is greater than any number here. Because check the order of comparison in elixir

  # number < atom < reference < function < port <
  # pid < tuple < map < list < bitstring

  # Atom in Elixir is greater than any Number
  # Here :point_right: Infinity in Elixir/Erlang? 24
  # def minValue([]), do: :infinity

  # def minValue([head | tail]) do
  #   result = minValue(tail)

  #   if result < head do
  #     result
  #   else
  #     head
  #   end
  # end
  # ANOTHER IMPLEMENTATION FOR MIN VALUE with Tail Call
  def minValue([head | tail]), do: minValue(tail, head)

  defp minValue([head | tail], value) when value > head do
    minValue(tail, head)
  end

  defp minValue([head | tail], value) when value < head do
    minValue(tail, value)
  end

  defp minValue([], value) do
    value
  end
end

# IO.inspect(Lister.square([1, 2, 3, 4]))

# IO.inspect(Lister.addNumber([1, 2, 3, 4], 10))

# IO.inspect(Lister.mapper([1, 2, 3, 4], &(&1 * 10)))

# IO.inspect(
#   Lister.reducer([1, 2, 3, 4], 0, fn
#     value, _ ->
#       value + 10
#   end)
# )

IO.inspect(Lister.mapSum([1, 2, 3], &(&1 * &1)))
IO.inspect(Lister.maxValue([11, 10, 30, 1, 91, 8, 9]))
IO.inspect(Lister.minValue([11, 10, 30, 100, 91, 8, 9]))
