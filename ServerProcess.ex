defmodule DatabaseServer do
  # other process
  def start(num) do
    spawn(fn ->
      # connection = :rand.uniform(1000)
      loop(num)
    end)
  end

  def run_async(server_pid, query_def) do
    send(server_pid, {:run_query, self(), query_def})
  end

  def get_result do
    receive do
      {:query_result, result} -> result
    after
      5000 -> {:error, "Hell"}
    end
  end

  def get_value(server_pid) do
    send(server_pid, {:get_value, self()})

    receive do
      {:get_value, result} -> IO.inspect("Get Value #{result}")
    after
      999 -> {:error, :timeout}
    end
  end

  # other process
  defp loop(connection) do
    receive do
      {:run_query, caller, query_def} ->
        send(caller, {:query_result, run_query(connection, query_def)})

      # code
      {:get_value, caller} ->
        IO.puts(".............")
        send(caller, {:get_value, connection})
    end

    loop(connection)
  end

  defp run_query(connection, query_def) do
    Process.sleep(1000)
    "Connection #{connection}: #{query_def} result"
  end
end

server_pid = DatabaseServer.start(1)

DatabaseServer.run_async(server_pid, "query 1")
# DatabaseServer.run_async(server_pid, "query 2")
# DatabaseServer.run_async(server_pid, "query 3")
DatabaseServer.get_value(server_pid)
IO.puts("lala")
IO.inspect(DatabaseServer.get_result())
# IO.inspect(DatabaseServer.get_result())
# IO.inspect(DatabaseServer.get_result())

# Now with pool of database server

# pool = Enum.map(1..50, fn x -> DatabaseServer.start(x) end)

# Enum.each(1..30, fn query_def ->
#   # pool list may be map for better performance
#   server_pid = Enum.at(pool, :rand.uniform(50) - 1)
#   DatabaseServer.run_async(server_pid, query_def)
# end)

# Enum.map(1..30, fn _ -> IO.inspect(DatabaseServer.get_result()) end)
