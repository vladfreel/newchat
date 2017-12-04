require 'rails_helper'

RSpec.describe Like, :type => :model do
  it 'Like belong to Image' do
    should belong_to(:image)
  end
  it 'Like belong to User' do
    should belong_to(:user)
  end
  #it "enforces uniqueness" do
  #  should validate_uniqueness_of(:user).scoped_to(:image_id)
  #end
end
