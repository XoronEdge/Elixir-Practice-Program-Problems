defmodule KeyValueStore do
  use GenServer
  #   There are many differences between ServerProcess and GenServer, but a couple points deserve
  # special mention.
  # First, GenServer.start/2 works synchronously. In other words, start/2 returns only after
  # the init/1 callback has finished in the server process. Consequently, the client process that starts the
  # server is blocked until the server process is initialized.
  # Second, note that GenServer.call/2 doesn’t wait indefinitely for a response. By default, if the
  # response message doesn’t arrive in five seconds, an error is raised in the client process. You can alter
  # this by using GenServer.call(pid, request, timeout), where the timeout is given in
  # milliseconds. In addition, if the receiver process happens to terminate while you’re waiting for the
  # response, GenServer detects it and raises a corresponding error in the caller process.
  ## ////////////////////////////////////////Provide Interface to use this GenServer
  def start do
    GenServer.start(KeyValueStore, nil)
  end

  def put(pid, key, value) do
    GenServer.cast(pid, {:put, key, value})
  end

  def get(pid, key) do
    GenServer.call(pid, {:get, key})
  end

  ### ///////////////////Implement GenServer behavior below
  def init(_) do
    {:ok, %{}}
  end

  def handle_cast({:put, key, value}, state) do
    {:noreply, Map.put(state, key, value)}
  end

  def handle_call({:get, key}, _, state) do
    # reply response state
    {:reply, Map.get(state, key), state}
  end
end

IO.inspect(KeyValueStore.__info__(:functions))

IO.inspect(GenServer.start(KeyValueStore, nil))

{:ok, pid} = KeyValueStore.start()
KeyValueStore.put(pid, :some_key, :some_value)
IO.inspect(KeyValueStore.get(pid, :some_key))

# Stopping the server
# Different callbacks can return various types of responses. So far, you’ve seen the most common cases:
# • {:ok, initial_state} from init/1
# • {:reply, response, new_state} from handle_call/3
# • {:noreply, new_state} from handle_cast/2 and handle_info/2
# There are additional possibilities, the most important one being the option to stop the server process.
# In init/1, you can decide against starting the server. In this case, you can either return {:stop,
# reason} or :ignore. In both cases, the server won’t proceed with the loop, and will instead
# terminate.
# If init/1 returns {:stop, reason}, the result of start/2 will be {:error, reason}. In
# contrast, if init/1 returns :ignore, the result of start/2 will also be :ignore. The difference
# between these two return values is in their intention. You should opt for {:stop, reason} when
# you can’t proceed further due to some error. In contrast, :ignore should be used when stopping the
# server is the normal course of action.
# Returning {:stop, reason, new_state} from handle_* callbacks causes GenServer to
# stop the server process. If the termination is part of the standard workflow, you should use the
# atom :normal as the stoppage reason. If you’re in handle_call/3 and also need to respond to the
# caller before terminating, you can return {:stop, reason, response, new_state}.
# You may wonder why you need to return a new state if you’re terminating the process. The reason is
# that just before the termination, GenServer calls the callback function terminate/2, sending it
# the termination reason and the final state of the process. This can be useful if you need to perform
# cleanup.
# Finally, you can also stop the server process by invoking GenServer.stop/3 from the client
# process. This invocation will issue a synchronous request to the server. The behaviour will handle the
# stop request itself by stopping the server process.

# A cast is a fire-and-forget type of request — a caller sends a message and immediately moves
# on to do something else.
# • A call is a synchronous send-and-respond request — a caller sends a message and waits until the
# response arrives, the timeout occurs, or the server crashes.
