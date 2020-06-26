100.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@co.jp"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end