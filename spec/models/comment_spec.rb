require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe 'to_s' do
    before(:each) do
      @user = create(:user)
      @category = create(:category, user_id: @user.id)
      @image_del = create(:image, user_id: @user.id, category_id: @category.id)
      @comment = create(:comment, user_id: @user.id, image_id: @image_del.id)
    end
    it 'should return foo (to_s)' do
      expect(@comment.to_s) == @comment.id
    end
  end
  it 'Comment belong to Image' do
    expect(subject).to belong_to(:image)
  end
  it 'Comment belong to User' do
    expect(subject).to belong_to(:user)
  end
  it 'validates the com_email ' do
    expect(subject).to validate_presence_of(:com_email)
  end
  it 'validates the body ' do
    expect(subject).to validate_presence_of(:body)
  end
  describe '#com_email' do
    it 'should validate presence' do
      record = Comment.new
      record.com_email = ''
      record.valid?
      expect(record.errors[:com_email]).to include('Не введен заголовок')
      record.com_email = 'cars'
      record.valid?
      expect(record.errors[:com_email]).not_to include('Не введен заголовок')
    end
  end
  describe '#body' do
    it 'should validate presence' do
      record = Comment.new
      record.body = ''
      record.valid?
      expect(record.errors[:body]).to include('Не введен текст')
      record.body = 'cars'
      record.valid?
      expect(record.errors[:body]).not_to include('Не введен текст')
    end
  end
end
