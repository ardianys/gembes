json.array!(@transactions) do |transaction|
  json.extract! transaction, :id,  :from_wallet_id,  :to_wallet_id,  :from_who_id,  :to_who_id,  :from_who_class,  :to_who_class,  :amount,  :created_at, :updated_at
end