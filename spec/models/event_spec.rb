require 'rails_helper'
RSpec.describe Event, type: :model do
  describe 'to_s' do
    it 'should return foo (to_s)' do
      @user = create(:user)
      @event = Event.create(user_id: @user.id)
      expect(@event.to_s) == @event.id
    end
  end
  it 'Event belong to User' do
    expect(subject).to belong_to(:user)
  end
end
