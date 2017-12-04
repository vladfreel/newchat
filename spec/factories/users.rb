FactoryGirl.define do
  factory :user do
    email {Faker::Internet.email}
    password "password"
    password_confirmation "password"
    confirmed_at 7.days.ago
    avatar {Faker::Avatar.image}
  end
end