json.array!(@teams) do |team|
  json.extract! team, :id,  :name,  :created_at, :updated_at
end