require 'rails_helper'
describe "UserSignin" do
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
    visit new_user_session_path
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "Войти"
    visit new_category_path
    fill_in "category_name", :with => "category"
    click_on("Создать")
  end
  it "should click Подписаться ", js: true  do
    click_on("sub")
    page.should have_selector(:button, 'Отписаться')
  end
  it "should click Подписаться -> Отписаться ", js: true do
    click_on("sub")
    click_on("unsub")
    page.should have_selector(:button, 'Подписаться')
  end
end