require 'rails_helper'

RSpec.describe AdminUser, :type => :model do
  it 'validates the password on presence ' do
    should validate_presence_of(:encrypted_password)
  end
  it 'validates the password on length ' do
    should validate_length_of(:encrypted_password).is_at_least(6)
  end
  it 'validates the password on email ' do
    should validate_presence_of(:email)
  end
end