require 'rails_helper'
describe "add category" do
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
    visit new_user_session_path
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "Войти"
    visit new_category_path
    fill_in "category_name", :with => "category"
    click_on("Создать")
    expect(Category.count).to eq(1)
  end
  it "should add category", js: true do
    cat = Category.last.id
    current_path.should == "/ru" + category_path(id: cat)
  end
  it "should drop category", js: true do
    cat = Category.last.id
    current_path.should == "/ru" + category_path(id: cat)
    click_on("Удалить категорию")
    expect(Category.count).to eq(0)
  end

end