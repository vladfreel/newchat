FactoryGirl.define do
  factory :image do
    association :user_id,{ factory: :user }
    association :category_id,{ factory: :category }
    img { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/doska12.jpg')), 'image/jpeg') }
  end
end