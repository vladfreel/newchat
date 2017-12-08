FactoryBot.define do
  factory :image do |f|
    f.association :user_id,{ factory: :user }
    f.association :category_id,{ factory: :category }
    f.img { Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/doska12.jpg')), 'image/jpeg') }
  end
end