FactoryBot.define do
  factory :user do
    name { Faker::Name.name }
    email { Faker::Internet.email }
    password { Faker::Crypto.md5 }
    auth_token { Faker::Alphanumeric.alphanumeric(number: 10) }
  end

  factory :team do
    name { Faker::Company.name }
  end

  factory :stock do
    name { Faker::CryptoCoin.acronym }
  end

  factory :wallet do
    who_id { nil }
    who_class { nil }
    code { Faker::Number.number(digits: 6) }
    name { Faker::CryptoCoin.coin_name }

    transient do
      param_id { nil }
      param_class { nil }
    end

    trait :with_who do
      who_id { param_id }
      who_class { param_class }
    end

    trait :with_user do
      user = FactoryBot.create(:user)
      who_id  { user.id }
      who_class { 'User' }
    end

    trait :with_team do
      team = FactoryBot.create(:team)
      who_id  { team.id }
      who_class { 'Team' }
    end

    trait :with_stock do
      stock = FactoryBot.create(:stock)
      who_id  { stock.id }
      who_class { 'Stock' }
    end
  end

  factory :transaction do
    from_wallet_id { nil }
    to_wallet_id { nil }
    from_who_id { nil }
    to_who_id { nil }
    from_who_class { 'User' }
    to_who_class { 'User' }
    amount { 100 }

    trait :with_full do
      user1 = FactoryBot.create(:user)
      user2 = FactoryBot.create(:user)
      wallet1 = FactoryBot.create(:wallet, :with_user)
      wallet2 = FactoryBot.create(:wallet, :with_user)

      params = {
        to_wallet_id: wallet1.id,
        to_who_id: user1.id,
        to_who_class: user1.class.name,
        amount: 1000,
      }
      transaction = Transaction.new params
      transaction.save validate: false

      from_wallet_id { wallet1.id }
      to_wallet_id { wallet2.id }
      from_who_id { user1.id }
      to_who_id { user2.id }
      from_who_class { 'User' }
      to_who_class { 'User' }
    end
  end
end

