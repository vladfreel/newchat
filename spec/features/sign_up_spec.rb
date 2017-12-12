require 'rails_helper'
describe 'UserRegistration' do
  it 'allows a user to register' do
    user = create(:user)
    visit new_user_registration_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    fill_in 'user_password_confirmation', with: user.password
    click_button 'Зарегистрироваться'
    expect(current_path) == '/users/sign_in'
  end
  it 'should click EN ', js: true do
    visit new_user_registration_path
    click_on('loc_en')
    expect(page).to have_content('REGISTRATION')
    expect(page).to have_no_content('РЕГИСТРАЦИЯ')
  end

  it 'should click RU ', js: true do
    visit new_user_registration_path
    click_on('loc_en')
    click_on('loc_ru')
    expect(page).to have_content('РЕГИСТРАЦИЯ')
    expect(page).to have_no_content('REGISTRATION')
  end
end
