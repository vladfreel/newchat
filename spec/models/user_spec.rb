require 'rails_helper'
auth_hash = OmniAuth::AuthHash.new({
                                       :provider => 'twitter',
                                       :uid => '1234',
                                       :info => {
                                           :nickname => "user@twitter.com",
                                           :name => "Justin Bieber"
                                       }
                                   })
RSpec.describe User, :type => :model do
  it 'User has many comments' do
    should have_many(:comments).dependent(:destroy)
  end
  it 'User has many events' do
    should have_many(:events).dependent(:destroy)
  end
  it 'User has many likes' do
    should have_many(:likes).dependent(:destroy)
  end
  it 'User has many subscribes' do
    should have_many(:subs)
  end
  it 'User has many categories where he is owner' do
    should have_many(:categories_owner).class_name('Category').with_foreign_key('user_id').dependent(:destroy)
  end
  it 'User has many categories ' do
    should have_many(:categories).through(:subs).dependent(:destroy)
  end
  it 'validates the email ' do
    should validate_presence_of(:email)
  end
  it 'validates the password on presence ' do
    should validate_presence_of(:encrypted_password)
  end
  it 'validates the password on length ' do
    should validate_length_of(:encrypted_password).is_at_least(6)
  end
  it do
    should accept_nested_attributes_for(:categories).allow_destroy(true)
  end
  it "retrieves an existing user" do
    user = User.new(
        :provider => "twitter",
        :uid => 1234,
        :email => "user@twitter.com",
        :password => 'password',
        :password_confirmation => 'password'
    )
    user.skip_confirmation!
    user.save
    omniauth_user = User.from_omniauth(auth_hash)
    expect(user).to eq(omniauth_user)
  end
  it "creates a new user if one doesn't already exist" do
    expect(User.count).to eq(0)
    omniauth_user = User.from_omniauth(auth_hash)
    expect(User.count).to eq(1)
  end

end
