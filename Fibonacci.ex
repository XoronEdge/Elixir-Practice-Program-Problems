defmodule Fibonacci do
  def getFib(n) when n < 2, do: n

  def getFib(number) do
    result = getFib(number - 1) + getFib(number - 2)
  end
end

IO.puts(Fibonacci.getFib(5))
