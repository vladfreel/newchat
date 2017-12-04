FactoryGirl.define do
  factory :admin_user do
    email {Faker::Internet.email}
    encrypted_password 'encrypted_password'
  end
end