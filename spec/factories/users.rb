FactoryBot.define do
  factory :user do
    name { 'ユーザー' }
    sequence(:email) { |n| "user#{n}@test.com" }
    password { '123456' }
    password_confirmation { '123456' }
    introduction { 'ユーザーです。よろしくお願いします。' }
    is_valid { true }
  end

  factory :bob, class: User do
    name { 'Bob' }
    sequence(:email) { |n| "bob#{n}@test.com" }
    password { '123456' }
    password_confirmation { '123456' }
    introduction { 'Bobです。よろしくお願いします。' }
    is_valid { true }
  end
end