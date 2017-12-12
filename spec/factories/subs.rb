FactoryBot.define do
  factory :sub do |f|
    f.association :category_id, factory: :category
    f.created_at 7.days.ago
    f.updated_at 7.days.ago
  end
end
