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
end