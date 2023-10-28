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
  factory :wallet do
    who_id nil
    who_class nil
    code { Faker::Number.number(digits: 6) }
    name { Faker::Lorem.name }
  end
end

