require 'rails_helper'

RSpec.describe Stock, type: :request do
  describe 'CRUD' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'create new Stock' do
      name = Faker::Name.name
      params = {
        name: name,
      }
      spost @user, url_for([:user_api, :stocks]), params
      expect(response.body).to include(name)
    end
  end
end
