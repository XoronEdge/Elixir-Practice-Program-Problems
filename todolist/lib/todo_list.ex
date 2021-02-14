defmodule TodoList do
  alias MultiDict

  defstruct auto_id: 1, entries: %{}
  def new, do: %TodoList{}

  def add_entry(todo_list, entry) do
    entry = Map.put(entry, :id, todo_list.auto_id)
    new_entries = Map.put(todo_list.entries, todo_list.auto_id, entry)
    %TodoList{todo_list | entries: new_entries, auto_id: todo_list.auto_id + 1}
  end

  def entries(todo_list, date),
    do:
      Enum.filter(todo_list.entries, fn {_, entry} -> entry.date == date end)
      |> Enum.map(fn {_, entry} -> entry end)

  def update_entry(todo_list, id, updateLambda) do
    case Map.fetch(todo_list.entries, id) do
      :error ->
        todo_list

      {:ok, entry} ->
        entry_id = entry.id
        entry = %{id: ^entry_id} = updateLambda.(entry)
        update_entries = Map.put(todo_list.entries, entry.id, entry)
        %TodoList{todo_list | entries: update_entries}
    end
  end
end

entry1 = %{date: ~D[2020-12-12], title: "enrty 1"}
entry2 = %{date: ~D[2020-11-12], title: "enrty 2"}
entry3 = %{date: ~D[2020-12-12], title: "enrty 3"}
entry4 = %{date: ~D[2020-11-12], title: "enrty 4"}

todo =
  TodoList.new()
  |> TodoList.add_entry(entry1)
  |> TodoList.add_entry(entry2)
  |> TodoList.add_entry(entry3)
  |> TodoList.add_entry(entry4)

# IO.inspect(todo)
# IO.inspect(TodoList.entries(todo, ~D[2020-12-12]))
IO.inspect(TodoList.update_entry(todo, 2, fn entry -> %{entry | title: "Updater"} end))
