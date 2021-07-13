FactoryBot.define do
  factory :user do
    name { 'ユーザー' }
    sequence(:email) { |n| "user#{n}@test.com" }
    password { '123456' }
    password_confirmation { '123456' }
    introduction { 'ユーザーです。よろしくお願いします。' }
    is_valid { true }
  end
end