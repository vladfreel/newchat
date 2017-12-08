FactoryBot.define do
  factory :like do |f|
    f.association :image_id,{ factory: :image }
  end
end