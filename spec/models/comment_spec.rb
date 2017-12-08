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
  it 'validates the com_email ' do
    should validate_presence_of(:com_email)
  end
  it 'validates the body ' do
    should validate_presence_of(:body)
  end
  describe '#com_email' do
    it 'should validate presence' do
      record = Comment.new
      record.com_email = '' # invalid state
      record.valid? # run validations
      record.errors[:com_email].should include("Не введен заголовок") # check for presence of error

      record.com_email = 'cars' # valid state
      record.valid? # run validations
      record.errors[:com_email].should_not include("Не введен заголовок") # check for absence of error
    end
  end
  describe '#body' do
    it 'should validate presence' do
      record = Comment.new
      record.body = '' # invalid state
      record.valid? # run validations
      record.errors[:body].should include("Не введен текст") # check for presence of error

      record.body = 'cars' # valid state
      record.valid? # run validations
      record.errors[:body].should_not include("Не введен текст") # check for absence of error
    end
  end
end