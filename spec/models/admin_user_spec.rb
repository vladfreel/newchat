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
  describe '#email' do
    it 'should validate presence' do
      record = AdminUser.new
      record.email = '' # invalid state
      record.valid? # run validations
      record.errors[:email].should include("Не может быть пустым") # check for presence of error

      record.email = 'foo@bar.com' # valid state
      record.valid? # run validations
      record.errors[:email].should_not include("Не может быть пустым") # check for absence of error
    end
  end
  describe '#password' do
    it 'should validate presence' do
      record = AdminUser.new
      record.email = 'foo@bar.com' # invalid state
      record.encrypted_password = ''
      record.valid? # run validations
      record.errors[:encrypted_password].should include("Не может быть пустым") # check for presence of error

      record.email = 'foo@bar.com' # valid state
      record.encrypted_password = '123456'
      record.valid? # run validations
      record.errors[:encrypted_password].should_not include("Не может быть пустым") # check for absence of error
    end
    it 'should validate length' do
      record = AdminUser.new
      record.email = 'foo@bar.com' # invalid state
      record.encrypted_password = '1234'
      record.valid? # run validations
      record.errors[:encrypted_password].should include("Слишком короткий") # check for presence of error

      record.email = 'foo@bar.com' # valid state
      record.encrypted_password = '123456'
      record.valid? # run validations
      record.errors[:encrypted_password].should_not include("Слишком короткий") # check for absence of error
    end
  end
end