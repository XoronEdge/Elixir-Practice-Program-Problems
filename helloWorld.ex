defmodule Raw do
  def show(a) when is_nil(a) != true do
    ho()
    IO.puts("Hell")
  end

  def show(a) do
    ho()
    IO.puts("HBell")
  end

  defp ho() do
    IO.puts("HOHO")
  end
end

# defmodule Raw do
#   def show(value) do
#     case value do
#       val when val in [1, 2] ->
#         IO.puts("Hello")

#       _other ->
#         IO.puts("Hell")
#     end
#   end
# end

Raw.show(3)

Raw.show("aa")
