FactoryBot.define do
  factory :post do
    before_image { File.open("#{Rails.root}/db/fixtures/icon0-min.jpg") }
    after_image { File.open("#{Rails.root}/db/fixtures/icon1-min.jpg") }
    caption { "キャプションです。" }
    association :user, factory: :user
  end
end