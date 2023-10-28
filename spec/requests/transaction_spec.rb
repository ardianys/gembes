require 'rails_helper'

RSpec.describe Transaction, type: :request do
  describe 'create Transaction' do
    before do
      @user1 = FactoryBot.create(:user)
      @user2 = FactoryBot.create(:user)
      @user1_wallet = FactoryBot.create(:wallet, who_id: @user1.id, who_class: 'User')
      @user2_wallet = FactoryBot.create(:wallet, who_id: @user2.id, who_class: 'User')

      @team1 = FactoryBot.create(:team)
      @team2 = FactoryBot.create(:team)
      @team1_wallet = FactoryBot.create(:wallet, who_id: @team1.id, who_class: 'Team')
      @team2_wallet = FactoryBot.create(:wallet, who_id: @team2.id, who_class: 'Team')

      @stock1 = FactoryBot.create(:stock)
      @stock2 = FactoryBot.create(:stock)
      @stock1_wallet = FactoryBot.create(:wallet, who_id: @stock1.id, who_class: 'Stock')
      @stock2_wallet = FactoryBot.create(:wallet, who_id: @stock2.id, who_class: 'Stock')
    end

    it 'Should not transfer coin from user1 to user2' do
      params = {
        from_wallet_id: @user1_wallet.id,
        to_wallet_id: @user2_wallet.id,
        from_who_id: @user1.id,
        to_who_id: @user2.id,
        from_who_class: 'User',
        to_who_class: 'User',
        amount: 100,
      }
      spost @user1, url_for([:user_api, :transactions]), params
      expect(response).to have_http_status(:unprocessable_entity)
    end


    it 'Should transfer coin from user1 to user2' do

      # Source wallet top up
      params = {
        # from_wallet_id: @user1_wallet.id,
        to_wallet_id: @user1_wallet.id,
        # from_who_id: @user1.id,
        to_who_id: @user1.id,
        # from_who_class: 'User',
        to_who_class: 'User',
        amount: 1000,
      }
      Transaction.create! params

      params = {
        from_wallet_id: @user1_wallet.id,
        to_wallet_id: @user2_wallet.id,
        from_who_id: @user1.id,
        to_who_id: @user2.id,
        from_who_class: 'User',
        to_who_class: 'User',
        amount: 100,
      }
      spost @user1, url_for([:user_api, :transactions]), params
      expect(response).to have_http_status(:created)
    end
  end
end