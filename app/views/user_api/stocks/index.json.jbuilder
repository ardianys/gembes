json.array!(@stocks) do |stock|
  json.extract! stock, :id,  :name,  :created_at, :updated_at
end