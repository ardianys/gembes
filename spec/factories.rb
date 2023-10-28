FactoryBot.define do
  factory :user do
    name { Faker::Lorem.name }
    email { Faker::Internet.email }
    password { Faker::Lorem.name }
    auth_token { Faker::Alphanumeric.alphanumeric(number: 10) }
  end
  factory :team do
    name { Faker::Lorem.name }
  end
  factory :stock do
    name { Faker::Lorem.name }
  end
  factory :wallet do
    transient do
      who_id { nil }
      who_class { nil }
    end

    code { Faker::Number.number(digits: 6) }
    name { Faker::Lorem.name }

    after(:create) do |wallet, evaluator|
      wallet.update who_id: evaluator.who_id, who_class: evaluator.who_class
    end
  end
end

