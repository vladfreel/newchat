require 'rails_helper'

RSpec.describe Comment, :type => :model do
  it 'Comment belong to Image' do
    should belong_to(:image)
  end
  it 'Comment belong to User' do
    should belong_to(:user)
  end
end