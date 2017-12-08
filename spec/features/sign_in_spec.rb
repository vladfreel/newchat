require 'rails_helper'
describe "UserSignin" do
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
    visit categories_path
  end
  it "should allow a registered user to sign in", js: true do
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "Войти"
    current_path.should == categories_path
  end
  it "should click EN " , js: true do
    click_on("loc_en")
    expect(page).to have_content("SIGN IN")
    expect(page).to have_no_content("ВХОД")
  end

  it "should click RU ", js: true  do
    click_on("loc_en")
    click_on("loc_ru")
    expect(page).to have_content("ВХОД")
    expect(page).to have_no_content("SIGN IN")
  end
  it "should not allow an unregistered user to sign in", js: true do
    fill_in "user_email", :with => "notarealuser@example.com"
    fill_in "user_password", :with => "fakepassword"
    click_button "Войти"
    page.should_not have_content("Welcome")
  end
  it "should click Забыли пароль", js: true do
    click_on("forgot_pass")
    current_path.should =='/users/password/new'
  end
  it "should click Забыли пароль", js: true do
    click_on("reg")
    current_path.should =='/users/sign_up'
  end
  it "should click Не получили подтверждения? ", js: true do
    click_on("conf")
    current_path.should =='/users/confirmation/new'
  end
  it "should click Не получили инструкции по разблокировке? ", js: true do
    click_on("unlock")
    current_path.should =='/users/unlock/new'
  end
end