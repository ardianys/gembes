namespace :user_api, defaults: { format: :json } do
  resources :users
  resources :stocks
  resources :wallets
  resources :teams
  resources :members
  resources :transactions
  post 'auth/sign_in', to: 'authentications#sign_in'
end