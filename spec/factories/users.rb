FactoryBot.define do
  factory :user do |f|
    f.email Faker::Internet.email
    f.password 'password'
    f.password_confirmation 'password'
    f.confirmed_at 7.days.ago
  end
end
