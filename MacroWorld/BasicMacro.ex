# defmodule My do
#   def myif(condition, clauses) do
#     do_clause = Keyword.get(clauses, :do, nil)
#     else_clause = Keyword.get(clauses, :else, nil)

#     case condition do
#       val when val in [false, nil] ->
#         else_clause

#       _otherwise ->
#         do_clause
#     end
#   end
# end

# My.myif(1 == 2, do: IO.puts("1 == 2"), else: IO.puts("1 != 2"))

defmodule My do
  defmacro __using__(_) do
    quote do
      # field :created_at, :utc_datetime_usec, autogenerate: {Ecto.Schema, DateTime.utc_now(), []}
      def show(value) do
        IO.puts("Show #{value}")
      end

      def show() do
        IO.puts("Show Nothing")
      end
    end
  end

  defmacro common_fields(argue) do
    quote do
      # field :created_at, :utc_datetime_usec, autogenerate: {Ecto.Schema, DateTime.utc_now(), []}      
      IO.inspect(unquote(argue))
    end
  end
end

defmodule Test do
  use My

  def shower() do
    My.common_fields(%{a: 10})
  end
end

# Test.show("Hello World")
Test.shower()
