require 'rails_helper'

RSpec.describe Sub, :type => :model do
  describe 'to_s' do
    before(:each) do
      @user = create(:user)
      @category = create(:category,user_id: @user.id)
      @sub = create(:sub,user_id: @user.id,category_id: @category.id)
    end
    it "should return foo (to_s)" do
      @sub.to_s.should == @sub.id
    end
  end
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
