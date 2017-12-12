FactoryBot.define do
  factory :comment do |f|
    f.association :image_id, factory: :image
    f.com_email Faker::Lorem.word
    f.body Faker::Lorem.sentence
  end
end
