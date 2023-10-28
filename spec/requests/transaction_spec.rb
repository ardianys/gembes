require 'rails_helper'

# Every request for credit/debit (deposit or withdraw) should
# be based on records in database for given model

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

    # User
    it 'Should transfer coin from user1 to user2 or team2' do
      # Source wallet top up
      params = {
        to_wallet_id: @user1_wallet.id,
        to_who_id: @user1.id,
        to_who_class: 'User',
        amount: 1000,
      }
      transaction = Transaction.new params
      transaction.save validate: false

      # user to user
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

      # user to team
      params = {
        from_wallet_id: @user1_wallet.id,
        to_wallet_id: @team2_wallet.id,
        from_who_id: @user1.id,
        to_who_id: @team2.id,
        from_who_class: 'User',
        to_who_class: 'Team',
        amount: 100,
      }
      spost @user1, url_for([:user_api, :transactions]), params
      expect(response).to have_http_status(:created)
    end

    # Team
    it 'Should transfer coin from team1 to team2 or user2' do
      # Source wallet top up
      params = {
        to_wallet_id: @team1_wallet.id,
        to_who_id: @team1.id,
        to_who_class: 'Team',
        amount: 1000,
      }
      transaction = Transaction.new params
      transaction.save validate: false

      # team to team
      params = {
        from_wallet_id: @team1_wallet.id,
        to_wallet_id: @team2_wallet.id,
        from_who_id: @team1.id,
        to_who_id: @team2.id,
        from_who_class: 'Team',
        to_who_class: 'Team',
        amount: 100,
      }
      spost @user1, url_for([:user_api, :transactions]), params
      expect(response).to have_http_status(:created)

      # team to user
      params = {
        from_wallet_id: @team1_wallet.id,
        to_wallet_id: @user2_wallet.id,
        from_who_id: @team1.id,
        to_who_id: @user2.id,
        from_who_class: 'Team',
        to_who_class: 'User',
        amount: 100,
      }
      spost @user1, url_for([:user_api, :transactions]), params
      expect(response).to have_http_status(:created)
    end

    # Stock
    it 'Should transfer coin from stock1 to stock2 or user2' do
      # Source wallet top up
      params = {
        to_wallet_id: @stock1_wallet.id,
        to_who_id: @stock1.id,
        to_who_class: 'Stock',
        amount: 1000,
      }
      transaction = Transaction.new params
      transaction.save validate: false

      # stock to stock
      params = {
        from_wallet_id: @stock1_wallet.id,
        to_wallet_id: @stock2_wallet.id,
        from_who_id: @stock1.id,
        to_who_id: @stock2.id,
        from_who_class: 'Stock',
        to_who_class: 'Stock',
        amount: 100,
      }
      spost @user1, url_for([:user_api, :transactions]), params
      expect(response).to have_http_status(:created)

      # stock to user
      params = {
        from_wallet_id: @stock1_wallet.id,
        to_wallet_id: @user2_wallet.id,
        from_who_id: @stock1.id,
        to_who_id: @user2.id,
        from_who_class: 'Stock',
        to_who_class: 'User',
        amount: 100,
      }
      spost @user1, url_for([:user_api, :transactions]), params
      expect(response).to have_http_status(:created)
    end
  end
end