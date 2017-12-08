require 'rails_helper'

RSpec.describe Comment, :type => :model do
  describe 'to_s' do
    before(:each) do
      @user = create(:user)
      @category = create(:category,user_id: @user.id)
      @image_del = create(:image, user_id: @user.id, category_id: @category.id)
      @comment = create(:comment,user_id: @user.id,image_id: @image_del.id)
    end
    it "should return foo (to_s)" do
      @comment.to_s.should == @comment.id
    end
  end
  it 'Comment belong to Image' do
    should belong_to(:image)
  end
  it 'Comment belong to User' do
    should belong_to(:user)
  end
end