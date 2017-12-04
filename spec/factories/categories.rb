FactoryGirl.define do
  factory :category do
    name {Faker::Name.name}
    association :id, :factory => :user
  end
end