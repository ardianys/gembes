require 'rails_helper'

RSpec.describe Team, type: :request do
  describe 'create first wallet' do
    before do
      @user = FactoryBot.create(:user)
      @team = FactoryBot.create(:team)
    end

    it 'create new wallet for team' do
      code = Faker::Number.number(digits: 6).to_s
      params = {
        who_id: @team.id,
        who_class: 'Team',
        code: code,
        name: Faker::Name.name,
      }
      spost @user, user_api_wallets_path, params

      expect(response.body).to include(code)

      sget @user, '/user_api/wallets'
      expect(response).to have_http_status(:ok)
      expect(json.size).to be >= 1
    end
  end
end
