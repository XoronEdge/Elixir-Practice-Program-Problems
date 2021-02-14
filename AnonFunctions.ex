sum = fn a, b, c -> a + b + c end
concat_list = fn a, b -> a ++ b end
pair_tuple_to_list = fn tuple -> Tuple.to_list(tuple) end

handle_open = fn
  {:ok, file} -> "Read data: #{IO.read(file, :line)}"
  {_, error} -> "Error: #{:file.format_error(error)}"
end

handle_fizz_buzz = fn
  0, 0, c -> "fizzbuzz"
  0, b, c -> "fizz"
  a, 0, c -> "buzz"
  a, b, c -> c
end

IO.puts(sum.(1, 2, 3))
IO.inspect(concat_list.([:a, :b], [:c, :d]))
IO.inspect(pair_tuple_to_list.({1, 2}))
IO.puts(handle_fizz_buzz.(1, 0, 1))
