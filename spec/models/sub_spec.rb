require 'rails_helper'

RSpec.describe Sub, type: :model do
  describe 'to_s' do
    before(:each) do
      @user = create(:user)
      @category = create(:category, user_id: @user.id)
      @sub = create(:sub, user_id: @user.id, category_id: @category.id)
    end
    it 'should return foo (to_s)' do
      expect(@sub.to_s) == @sub.id
    end
  end
  it 'Subscribe belong to User' do
    expect(subject).to belong_to(:user)
  end
  it 'Subscribe belong to Category' do
    expect(subject).to belong_to(:category)
  end
end
