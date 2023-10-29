require 'rails_helper'

RSpec.describe Transaction, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @transaction = FactoryBot.create(:transaction, :with_full)
  end

  it "is valid with valid attributes" do
    expect(@transaction).to be_valid
  end

  it "is not valid with negative amount" do
    @transaction.amount = -100
    expect(@transaction).to_not be_valid
  end

  it "is not valid with wrong from_who_class" do
    @transaction.from_who_class = 'FROM_WHO_CLASS'
    expect(@transaction).to_not be_valid
  end

  it "is not valid with wrong to_who_class" do
    @transaction.to_who_class = 'TO_WHO_CLASS'
    expect(@transaction).to_not be_valid
  end

  describe "Validations" do
    it { should validate_presence_of(:from_wallet_id) }
    it { should validate_presence_of(:to_wallet_id) }
    it { should validate_presence_of(:from_who_id) }
    it { should validate_presence_of(:to_who_id) }
    it { should validate_presence_of(:from_who_class) }
    it { should validate_presence_of(:to_who_class) }
    it { should validate_presence_of(:amount) }
  end
end
