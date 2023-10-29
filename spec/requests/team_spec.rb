require 'rails_helper'

RSpec.describe Team, type: :request do
  describe 'CRUD' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'create new Team' do
      name = Faker::Name.name
      params = {
        name: name,
      }
      spost @user, url_for([:user_api, :teams]), params
      expect(response.body).to include(name)
    end
  end
end
