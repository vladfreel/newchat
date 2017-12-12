require 'rails_helper'
auth_hash = OmniAuth::AuthHash.new(provider: 'twitter',
                                   uid: '1234',
                                   info: { nickname: 'user@twitter.com',
                                           name: 'Justin Bieber' })
RSpec.describe User, type: :model do
  it 'User has many comments' do
    expect(subject).to have_many(:comments).dependent(:destroy)
  end
  it 'User has many events' do
    expect(subject).to have_many(:events).dependent(:destroy)
  end
  it 'User has many likes' do
    expect(subject).to have_many(:likes).dependent(:destroy)
  end
  it 'User has many subscribes' do
    expect(subject).to have_many(:subs)
  end
  it 'User has many categories where he is owner' do
    expect(subject).to have_many(:categories_owner).class_name('Category').with_foreign_key('user_id').dependent(:destroy)
  end
  it 'User has many categories ' do
    expect(subject).to have_many(:categories).through(:subs).dependent(:destroy)
  end
  it 'validates the email ' do
    expect(subject).to validate_presence_of(:email)
  end
  it 'validates the password on presence ' do
    expect(subject).to validate_presence_of(:encrypted_password)
  end
  it 'validates the password on length ' do
    expect(subject).to validate_length_of(:encrypted_password).is_at_least(6)
  end
  it do
    expect(subject).to accept_nested_attributes_for(:categories).allow_destroy(true)
  end
  it 'retrieves an existing user' do
    user = User.new(
      provider: 'twitter',
      uid: 1234,
      email: 'user@twitter.com',
      password: 'password',
      password_confirmation: 'password'
    )
    user.skip_confirmation!
    user.save
    omniauth_user = User.from_omniauth(auth_hash)
    expect(user).to eq(omniauth_user)
    expect(User.count).to eq(1)
  end
  describe 'to_s' do
    before(:each) do
      @user = create(:user)
    end
    it 'should return foo (to_s)' do
      expect(@user.to_s) == @user.email
    end
  end
  describe '#email' do
    it 'should validate presence' do
      record = User.new
      record.email = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:email]).to include('Не может быть пустым')
      record.email = 'foo@bar.com' # valid state
      record.valid? # run validations
      expect(record.errors[:email]).not_to include('Не может быть пустым') # check for absence of error
    end
  end
  describe '#password' do
    it 'should validate presence' do
      record = User.new
      record.email = 'foo@bar.com' # invalid state
      record.encrypted_password = ''
      record.valid? # run validations
      expect(record.errors[:encrypted_password]).to include('Не может быть пустым')
      record.email = 'foo@bar.com' # valid state
      record.encrypted_password = '123456'
      record.valid? # run validations
      expect(record.errors[:encrypted_password]).not_to include('Не может быть пустым') # check for absence of error
    end
    it 'should validate length' do
      record = User.new
      record.email = 'foo@bar.com' # invalid state
      record.encrypted_password = '1234'
      record.valid? # run validations
      expect(record.errors[:encrypted_password]).to include('Слишком короткий') # check for presence of error
      record.email = 'foo@bar.com' # valid state
      record.encrypted_password = '123456'
      record.valid? # run validations
      expect(record.errors[:encrypted_password]).not_to include('Слишком короткий') # check for absence of error
    end
  end
end
