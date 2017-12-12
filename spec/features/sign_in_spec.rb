require 'rails_helper'
describe 'UserSignin' do
  let(:user) { create(:user) }
  before(:each) do
    visit categories_path
  end
  it 'should allow a registered user to sign in', js: true do
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Войти'
    expect(current_path) == categories_path
  end
  it 'should click EN ', js: true do
    click_on('loc_en')
    expect(page).to have_content('SIGN IN')
    expect(page).to have_no_content('ВХОД')
  end

  it 'should click RU ', js: true do
    click_on('loc_en')
    click_on('loc_ru')
    expect(page).to have_content('ВХОД')
    expect(page).to have_no_content('SIGN IN')
  end
  it 'should not allow an unregistered user to sign in', js: true do
    fill_in 'user_email', with: 'notarealuser@example.com'
    fill_in 'user_password', with: 'fakepassword'
    click_button 'Войти'
    expect(page).to have_no_content('Welcome')
  end
  it 'should click Забыли пароль', js: true do
    click_on('forgot_pass')
    expect(current_path) == '/users/password/new'
  end
  it 'should click Забыли пароль', js: true do
    click_on('reg')
    expect(current_path) == '/users/sign_up'
  end
  it 'should click Не получили подтверждения? ', js: true do
    click_on('conf')
    expect(current_path) == '/users/confirmation/new'
  end
  it 'should click Не получили инструкции по разблокировке? ', js: true do
    click_on('unlock')
    expect(current_path) == '/users/unlock/new'
  end
end
