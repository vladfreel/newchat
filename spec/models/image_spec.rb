require 'rails_helper'
RSpec.describe Image, type: :model do
  it 'Image has many comments' do
    expect(subject).to have_many(:comments).dependent(:destroy)
  end
  it 'Image has many likes' do
    expect(subject).to have_many(:likes).dependent(:destroy)
  end
  it 'Image belong to Category' do
    expect(subject).to belong_to(:category)
  end
  it 'validates the img ' do
    expect(subject).to validate_presence_of(:img)
  end
  describe '#img' do
    it 'should validate presence' do
      record = Image.new
      record.img = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:img]).to include('Не загружена картинка')
      record.img = Rack::Test::UploadedFile.new(
        File.open(File.join(Rails.root, '/spec/fixtures/doska12.jpg')),
        'image/jpeg'
      )
      record.valid? # run validations
      expect(record.errors[:img]).not_to include('Не загружена картинка')
    end
  end
end
