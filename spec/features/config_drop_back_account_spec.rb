require 'rails_helper'
describe "UserSignOut" do
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
    visit categories_path
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "Войти"
    click_link('edit', :visible => false)
  end
  it "should click EN " , js: true do
    click_on("loc_en")
    expect(page).to have_content("Password")
    expect(page).to have_no_content("Пароль")
  end

  it "should click RU ", js: true  do
    click_on("loc_en")
    click_on("loc_ru")
    expect(page).to have_content("Пароль")
    expect(page).to have_no_content("Password")
  end
  it "should drop account", js: true do
    click_button "Удалить мой аккаунт"
    current_path.should == new_user_session_path
    expect(User.count).to eq(0)
  end
  it "should back on categories", js: true do
    click_on("Назад")
    current_path.should == "/ru/categories"
  end
  it "should error with password", js: true do
    fill_in "user_pass", :with => user.password + "1"
    click_on("change")
    expect(page).to have_content("Введите текущий пароль для подтверждения!")
    expect(page).to have_content("Пароли не совпадают!")
  end
  it "should error with password", js: true do
    fill_in "user_pass_conf", :with => user.password + "1"
    click_on("change")
    expect(page).to have_content("Введите текущий пароль для подтверждения!")
    expect(page).to have_content("Пароли не совпадают!")
  end
  it "should error with password and password_confirm", js: true do
    fill_in "user_pass", :with => user.password + "1"
    fill_in "user_pass_conf", :with => user.password + "1"
    click_on("change")
    expect(page).to have_content("Введите текущий пароль для подтверждения!")
  end
  it "should error with password and password_confirm", js: true do
    fill_in "user_pass", :with => user.password + "1"
    fill_in "user_pass_conf", :with => user.password + "1"
    fill_in "curr_pass", :with => user.password
    click_on("change")
    expect(page).to have_no_content("Введите текущий пароль для подтверждения!")
    expect(page).to have_no_content("Пароли не совпадают!")
    expect(page).to have_no_content("Вы ввели пароль 1 раз!")
  end
  it "should error with password and password_confirm", js: true do
    attach_file('user[avatar]', File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on("change")
    expect(page).to have_content("Введите текущий пароль для подтверждения!")
  end
  it "should error with password and password_confirm", js: true do
    attach_file('user[avatar]', File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    fill_in "curr_pass", :with => user.password
    click_on("change")
    expect(page).to have_no_content("Введите текущий пароль для подтверждения!")
  end
  it "should allow a registered user to sign in", js: true do
    click_link('Выйти из аккаунта', :visible => false)
    current_path.should == new_user_session_path
  end

end