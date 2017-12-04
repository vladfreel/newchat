FactoryGirl.define do
  factory :comment do
    association :user_id,{ factory: :user }
    association :image_id,{ factory: :image }
    com_email {Faker::Lorem.word}
    body {Faker::Lorem.sentence}
  end
end