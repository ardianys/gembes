require 'rails_helper'

RSpec.describe User, type: :request do
  describe 'Sign in' do
    before do
      @user = FactoryBot.create(:user)
      @password = Faker::Number.number(digits: 6)
      @user.set_password @password.to_s
    end

    it 'returns user detail on signin' do
      params = {
        email: @user.email,
        password: @password,
      }
      post user_api_auth_sign_in_path, params: params
      expect(response.body).to include(@user.email)
    end
  end
end
