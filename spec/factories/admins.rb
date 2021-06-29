FactoryBot.define do
  factory :admin do
    email { ENV['ADMIN_MAIL'] }
    password { ENV['ADMIN_PASS'] }
    password_confirmation { ENV['ADMIN_PASS'] }
  end
end