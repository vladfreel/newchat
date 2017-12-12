require 'rails_helper'

RSpec.describe Like, type: :model do
  describe 'to_s' do
    before(:each) do
      @user = create(:user)
      @category = create(:category, user_id: @user.id)
      @image_del = create(:image, user_id: @user.id, category_id: @category.id)
      @like = create(:like, user_id: @user.id, image_id: @image_del.id)
    end
    it 'should return foo (to_s)' do
      expect(@like.to_s) == @like.id
    end
  end
  it 'Like belong to Image' do
    expect(subject).to belong_to(:image)
  end
  it 'Like belong to User' do
    expect(subject).to belong_to(:user)
  end
end
