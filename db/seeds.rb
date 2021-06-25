Admin.create!(
  email: ENV['ADMIN_MAIL'],
  password: ENV['ADMIN_PASS']
)

Faker::Config.locale = :en
20.times do |n|
  email = "sample@user#{n + 1}.com"
  name = Faker::Name.name
  password = "password"
  User.create!(
    email: email,
    name: name,
    password: password,
    password_confirmation: password,
    profile_image: open("./db/fixtures/icon#{n}-min.jpg")
  )
end