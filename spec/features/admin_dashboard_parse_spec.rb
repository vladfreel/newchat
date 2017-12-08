require 'rails_helper'
describe "add category" do
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
    @user = create(:user)
    @category1 = create(:category,user_id: @user.id)
    @category2 = create(:category,user_id: @user.id)
    @category3 = create(:category,user_id: @user.id)
    @image1 = create(:image, user_id: @user.id, category_id: @category1.id)
    @image2 = create(:image, user_id: @user.id, category_id: @category2.id)
    @image3 = create(:image, user_id: @user.id, category_id: @category3.id)
    @comment1 = create(:comment, user_id: @user.id, image_id: @image1.id)
    @comment2 = create(:comment, user_id: @user.id, image_id: @image2.id)
    @comment3 = create(:comment, user_id: @user.id, image_id: @image3.id)
    @admin = create(:admin_user)
    visit new_admin_user_session_path
    fill_in "admin_user_email", :with => @admin.email
    fill_in "admin_user_password", :with => @admin.password
    click_on("Войти")
    current_path.should == "/admin"
  end
  it "check dashboard"  do

    expect(page).to have_content(@category1.name)
    expect(page).to have_content(@category2.name)
    expect(page).to have_content(@category3.name)

    expect(page).to have_content(@comment1.com_email)
    expect(page).to have_content(@comment2.com_email)
    expect(page).to have_content(@comment3.com_email)

    page.should have_css('img')

  end
  it "check dashboard"  do
    click_on("Parse")
    current_path.should == "/ru/admin/parse"
    fill_in "url", :with => "https://www.artmajeur.com/ru/"
    click_on("sub")
    current_path.should == "/ru/admin/parse/img"
    first(:button, "add").click
    expect(page).to have_content("Картинка подробнее")
  end
end