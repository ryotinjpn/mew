User.create!( 
  name:  "ゲスト",
  email: "guest@example.com",
  password:              "guestguest",
  password_confirmation: "guestguest",
  profile: "ゲストアカウントです！",
  youtube: "https://www.youtube.com/")

99.times do |n|
  name = "ユーザー#{n+1}"
  email = "#{n+1}@example.com"
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