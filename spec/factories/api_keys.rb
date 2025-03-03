FactoryBot.define do
  factory :api_key do
    user { nil }
    key { "MyString" }
    description { "MyString" }
  end
end
