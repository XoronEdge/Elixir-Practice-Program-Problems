Process.register(self(), :parent_process)

run_query = fn query_def, parentProcess ->
  Process.sleep(2000)
  send(:parent_process, "Parent Get From Child #{query_def} result")
  "#{query_def} result"
end

async_query = fn query_def ->
  spawn(fn -> run_query.(query_def) end)
end

parentProcess = self()
# IO.inspect(async_query.("query 1"))
IO.inspect(
  Enum.map(1..5, fn x -> spawn(fn -> IO.puts(run_query.("query #{x}", parentProcess)) end) end)
)

Enum.map(1..4, fn _ ->
  receive do
    value ->
      IO.puts(value)
      # after
      #   5000 -> IO.puts("message not received")
  end
end)

receive do
  value ->
    IO.puts(value)
    # after
    #   5000 -> IO.puts("message not received")
end

# Process.sleep(5000)
