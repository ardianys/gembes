require 'rails_helper'

RSpec.describe Wallet, type: :request do
  describe 'create first wallet' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'create new wallet for himself' do
      code = Faker::Number.number(digits: 6).to_s
      params = {
        who_id: @user.id,
        who_class: 'User',
        code: code,
        name: Faker::Lorem.name,
      }
      spost @user, user_api_wallets_path, params

      expect(response.body).to include(code)

      sget @user, '/user_api/wallets'
      expect(response).to have_http_status(:ok)
      expect(json.size).to eq(1)
    end
  end
end