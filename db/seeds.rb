User.create!( 
  name:  "ゲスト",
  email: "guest@example.com",
  password:              "guestguest",
  password_confirmation: "guestguest",
  profile: "ゲストアカウントです！",
  youtube: "https://www.youtube.com/")

99.times do |n|
  name = Faker::Name.name
  email = Faker::Internet.email
  password = "password"
  profile = "#{name}です！"
  youtube = "https://www.youtube.com/"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password,
               profile: profile,
               youtube: youtube)
end