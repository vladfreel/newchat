require 'rails_helper'

RSpec.describe Image, :type => :model do

  it 'Image has many comments' do
    should have_many(:comments).dependent(:destroy)
  end
  it 'Image has many likes' do
    should have_many(:likes).dependent(:destroy)
  end
  it 'Image belong to Category' do
    should belong_to(:category)
  end
  it 'validates the img ' do
    should validate_presence_of(:img)
  end
  describe '#img' do
    it 'should validate presence' do
      record = Image.new
      record.img = '' # invalid state
      record.valid? # run validations
      record.errors[:img].should include("Не загружена картинка") # check for presence of error

      record.img = Rack::Test::UploadedFile.new(File.open(File.join(Rails.root, '/spec/fixtures/doska12.jpg')), 'image/jpeg')  # valid state
      record.valid? # run validations
      record.errors[:img].should_not include("Не загружена картинка") # check for absence of error
    end
  end
end