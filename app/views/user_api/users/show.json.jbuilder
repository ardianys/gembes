json.extract! @user, :id,  :auth_token,  :email,  :name,  :password,  :created_at, :updated_at

json.wallets do
  json.array!(@user.wallets) do |wallet|
    json.extract! wallet, :id,  :who_id,  :who_class,  :code,  :name,  :created_at, :updated_at
  end
end