FactoryGirl.define do
  factory :sub do
    association :user_id,{ factory: :user }
    association :category_id,{ factory: :category }
    created_at 7.days.ago
    updated_at 7.days.ago
  end
end