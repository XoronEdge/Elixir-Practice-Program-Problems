lookup = [
  %{key: "foo", type: :string},
  %{key: "bar", type: :string},
  %{key: "baz", type: :string}
]

params = %{foo: "bananas", baz: "apples"}

# Desired Result
# output =
#   [
#     %{key: :foo, value: "bananas", type: :string},
#     %{key: :baz, value: "apples", type: :string},
#   ]

# Method One Simple One order not maintain
lookupMap = Map.new(lookup, &{&1.key, &1.type})

IO.inspect(lookupMap)

result =
  Enum.map(params, fn {k, v} ->
    %{key: k, value: v, type: lookupMap[Atom.to_string(k)]}
  end)

IO.inspect(result)
# End Method one
IO.puts("End of Method one")
# Method Two By Reducer
resultByReducer =
  Enum.reduce(lookup, [], fn %{key: string_key, type: type} = map, acc ->
    case(Enum.find(params, fn {k, v} -> k == String.to_atom(string_key) end)) do
      # ++ for maintain order or we can use [|acc] for non order
      {atom_key, value} -> acc ++ [%{key: atom_key, value: value, type: type}]
      nil -> acc
    end
  end)

IO.inspect(resultByReducer)
# End Method By Reducer

### key findings 
# Enum.find take map retun tuple
# Map.new create map from list of map using transform last argue

records =
  IO.inspect(
    Enum.reduce(params["skills"], fn acc, title ->
      acc ++
        [Data.Skill.changeset(%Data.Skill{}, %{title: title, profile_id: params["profile_id"]})]
    end)
  )
