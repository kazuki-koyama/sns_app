Admin.create!(
  email: ENV['ADMIN_MAIL'],
  password: ENV['ADMIN_PASS']
)