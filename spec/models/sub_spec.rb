require 'rails_helper'

RSpec.describe Sub, :type => :model do
  it 'Subscribe belong to User' do
    should belong_to(:user)
  end
  it 'Subscribe belong to Category' do
    should belong_to(:category)
  end
  #it "enforces uniqueness" do
  #  should validate_uniqueness_of(:user).scoped_to(:image_id)
  #end
end
