require 'rails_helper'

RSpec.describe Event, :type => :model do
  describe 'to_s' do
  before(:each) do
    @user = create(:user)
    @event = Event.create(user_id: @user.id)
  end
  it "should return foo (to_s)" do
    @event.to_s.should == @event.id
  end
  end
  it 'Event belong to User' do
    should belong_to(:user)
  end

end
