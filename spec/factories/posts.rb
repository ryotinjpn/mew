FactoryBot.define do
  factory :post do
    content { Faker::Lorem.sentence }
    picture { File.open("#{Rails.root}/public/images/test_image.jpg") }
    user
  end
end
