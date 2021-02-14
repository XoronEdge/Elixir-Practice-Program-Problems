defmodule Concat do
  # A function head declaring defaults
  def join(a, b \\ nil, sep \\ "A")

  def join(a, b, _sep) when is_nil(b) do
    IO.puts("Hell")
    a
  end

  def join(a, b, sep) do
    IO.puts("Hello")
    a <> sep <> b
  end
end

# => Hello world
IO.puts(Concat.join("Hello", "A"))
# => Hello_world
# IO.puts(Concat.join("Hello", "world", "_"))
# IO.puts(Concat.join("Hello"))
