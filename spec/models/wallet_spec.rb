require 'rails_helper'

RSpec.describe Wallet, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @wallet = FactoryBot.create(:wallet, :with_who, param_id: @user.id, who_class: 'User')
    @wallet_user = FactoryBot.create(:wallet, :with_user)
    @wallet_team = FactoryBot.create(:wallet, :with_team)
    @wallet_stock = FactoryBot.create(:wallet, :with_stock)
  end

  it "is valid with valid attributes" do
    expect(@wallet).to be_valid
    expect(@wallet_user).to be_valid
    expect(@wallet_team).to be_valid
    expect(@wallet_stock).to be_valid
  end

  it "is not valid with wrong who_class" do
    @wallet.who_class = 'WHO_CLASS'
    expect(@wallet).to_not be_valid
  end

  describe "Validations" do
    it { should validate_presence_of(:who_id) }
    it { should validate_presence_of(:who_class) }
    it { should validate_presence_of(:code) }
    it { should validate_presence_of(:name) }
  end
end