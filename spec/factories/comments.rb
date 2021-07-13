FactoryBot.define do
  factory :comment do
    comment { "テスト用コメントです。" }
    association :user, factory: :user
    association :post, factory: :post
  end
end