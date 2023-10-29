require 'rails_helper'

# Based on relationships every entity e.g. User, Team, Stock or any other should
# have their own defined "wallet" to which we could transfer money or withdraw

RSpec.describe Wallet, type: :request do
  describe 'create first wallet' do
    before do
      @user = FactoryBot.create(:user)
      @team = FactoryBot.create(:team)
      @stock = FactoryBot.create(:stock)
    end

    it 'no wallet for all' do
      expect(@user.wallets.size).to eq(0)
      expect(@team.wallets.size).to eq(0)
      expect(@stock.wallets.size).to eq(0)
    end

    it 'create new wallet for himself' do
      code = Faker::Number.number(digits: 6).to_s
      params = {
        who_id: @user.id,
        who_class: 'User',
        code: code,
        name: Faker::Name.name,
      }
      spost @user, url_for([:user_api, :wallets]), params
      expect(response.body).to include(code)
      expect(@user.wallets.size).to be >= 1

      # check wallet entity
      sget @user, url_for([:user_api, @user.wallets.first])
      expect(response.body).to include(code)
      expect(json['owner']).not_to be nil
      expect(json['owner']['email']).to be == @user.email

      # create new wallets for no User type
      code = Faker::Number.number(digits: 6).to_s
      params = {
        who_id: @team.id,
        who_class: 'Team',
        code: code,
        name: Faker::Name.name,
      }
      spost @user, url_for([:user_api, :wallets]), params

      # New team's wallet should not belong to the user
      sget @user, url_for([:user_api, @user])
      expect(json['wallets'].count).to be == @user.wallets.size
    end

    it 'create new wallet for Team' do
      code = Faker::Number.number(digits: 6).to_s
      params = {
        who_id: @team.id,
        who_class: 'Team',
        code: code,
        name: Faker::Name.name,
      }
      spost @user, url_for([:user_api, :wallets]), params
      expect(response.body).to include(code)
      expect(@team.wallets.size).to be >= 1
    end

    it 'create new wallet for Stock' do
      code = Faker::Number.number(digits: 6).to_s
      params = {
        who_id: @stock.id,
        who_class: 'Stock',
        code: code,
        name: Faker::Name.name,
      }
      spost @user, url_for([:user_api, :wallets]), params
      expect(response.body).to include(code)
      expect(@stock.wallets.size).to be >= 1
    end
  end
end