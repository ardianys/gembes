json.array!(@users) do |user|
  json.extract! user, :id,  :auth_token,  :email,  :name,  :password,  :created_at, :updated_at
end