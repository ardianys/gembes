json.array!(@wallets) do |wallet|
  json.extract! wallet, :id,  :who_id,  :who_class,  :code,  :name,  :created_at, :updated_at
end