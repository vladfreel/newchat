require 'rails_helper'

RSpec.describe Like, :type => :model do
  describe 'to_s' do
    before(:each) do
      @user = create(:user)
      @category = create(:category,user_id: @user.id)
      @image_del = create(:image, user_id: @user.id, category_id: @category.id)
      @like = create(:like,user_id: @user.id,image_id: @image_del.id)
    end
    it "should return foo (to_s)" do
      @like.to_s.should == @like.id
    end
  end
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
