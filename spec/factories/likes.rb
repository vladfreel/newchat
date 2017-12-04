FactoryGirl.define do
  factory :like do
    association :user_id,{ factory: :user }
    association :image_id,{ factory: :image }
  end
end