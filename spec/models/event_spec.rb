require 'rails_helper'

RSpec.describe Event, :type => :model do
  it 'Event belong to User' do
    should belong_to(:user)
  end
end
