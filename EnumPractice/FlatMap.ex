list = [1, 2, 3, 4, 5]

lookup = [
  %{key: "foo", type: :string},
  %{key: "bar", type: :string},
  %{key: "baz", type: :string}
]

params = %{"foo" => "bananas", "baz" => "apples"}

result =
  Enum.flat_map(lookup, fn
    %{key: string_key, type: type} = map
    when is_map_key(params, :erlang.map_get(:key, map)) ->
      ["A"]

    _ ->
      []
  end)

IO.inspect(result)

IO.puts(Enum.at(list, 10, 10))
