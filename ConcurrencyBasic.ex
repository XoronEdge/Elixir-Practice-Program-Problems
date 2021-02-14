# its is baisc cuncunrrent and message passing between process
total_process = 10000

run_query = fn query_def ->
  Process.sleep(10000)
  "#{query_def} result"
end

# Enum.map(1..5, &run_query.("query #{&1}"))

async_query = fn query_def ->
  caller = self()
  spawn(fn -> send(caller, {:query_result, run_query.(query_def), limit: query_def}) end)
end

Enum.each(1..total_process, &async_query.(&1))

# send(self(), "Great Message")

get_result = fn ->
  receive do
    {:query_result, result, limit} ->
      IO.inspect(limit)
      result
  end

  # get_result()
end

# receive do
#   message -> IO.inspect(message)
#   {:query_result, result} -> IO.inspect(result)
# after
#   3000 -> IO.puts("message not received")
# end

result = Enum.map(1..total_process, fn _ -> get_result.() end)
IO.inspect(result)
Process.sleep(3000)
