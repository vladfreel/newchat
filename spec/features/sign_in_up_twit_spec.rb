require 'rails_helper'
describe 'UserRegistration by omniauth' do
  it 'allows a user to register', js: true do
    visit new_user_session_path
    click_link('Twitter')
    expect(User.count).to eq(1)
  end
end
