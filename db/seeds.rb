100.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  email = "example-#{n+1}@co.jp"
  password = "password"
  profile = Faker::Lorem.sentence 
  youtube = Faker::Internet.url
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               profile: profile,
               youtube: youtube
              )
end