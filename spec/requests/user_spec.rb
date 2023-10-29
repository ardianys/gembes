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

  describe 'CRUD' do
    before do
      @user = FactoryBot.create(:user)
    end

    it 'create new User' do
      name = Faker::Name.name
      email = Faker::Internet.email
      password = Faker::Crypto.md5
      auth_token = Faker::Alphanumeric.alphanumeric(number: 10)

      params = {
        name: name,
        email: email,
        password: password,
        auth_token: auth_token,
      }

      spost @user, url_for([:user_api, :users]), params
      expect(response.body).to include(name)
    end
  end
end
