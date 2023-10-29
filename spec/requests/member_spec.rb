require 'rails_helper'

RSpec.describe Member, type: :request do
  describe 'CRUD' do
    before do
      @user = FactoryBot.create(:user)
      @team = FactoryBot.create(:team)
    end

    it 'create new Stock' do
      params = {
        user_id: @user.id,
        team_id: @team.id,
      }
      spost @user, url_for([:user_api, :members]), params
      expect(response.body).to include(@user.name)
    end
  end
end
