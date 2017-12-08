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
    @like = create(:like, user_id: @user.id, image_id: @image3.id)
    @event = Event.create(user_id: @user.id, action_type: "some")
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
  it "check parse"  do
    click_on("Parse")
    current_path.should == "/ru/admin/parse"
    fill_in "url", :with => "https://www.artmajeur.com/ru/"
    click_on("sub")
    current_path.should == "/ru/admin/parse/img"
    first(:button, "add").click
    expect(page).to have_content("Картинка подробнее")
  end
  it "check user"  do
    click_on("Пользователь")
    current_path.should == "/ru/admin/users"
    expect(page).to have_content(@user.id)
    expect(page).to have_content(@user.email)
    expect(page).to have_content(@user.reset_password_token)
    expect(page).to have_content(@user.reset_password_sent_at)
    expect(page).to have_content(@user.remember_created_at)
    expect(page).to have_content(@user.current_sign_in_at)
    expect(page).to have_content(@user.last_sign_in_at)
    expect(page).to have_content(@user.current_sign_in_ip)
    expect(page).to have_content(@user.last_sign_in_ip)
    expect(page).to have_content(@user.provider)
    expect(page).to have_content(@user.uid)
    expect(page).to have_content(@user.failed_attempts)
    expect(page).to have_content(@user.unlock_token)
    expect(page).to have_content(@user.locked_at)
    expect(page).to have_content(@user.cached_failed_attempts)
    expect(page).to have_content(@user.confirmation_token)
    expect(page).to have_content(@user.avatar)
  end
  it "check comment"  do
    click_on("User Comments")
    current_path.should == "/ru/admin/user_comments"
    expect(page).to have_content(@comment1.id)
    expect(page).to have_content(@comment1.com_email)
    expect(page).to have_content(@comment1.body)
    expect(page).to have_content(@comment1.image.id)
  end
  it "check like"  do
    click_on("Лайк")
    current_path.should == "/ru/admin/likes"
    expect(page).to have_content(@like.id)
    expect(page).to have_content(@like.image.id)
    expect(page).to have_content(@like.user.login)
  end
  it "check events"  do
    click_on("Events")
    current_path.should == "/ru/admin/events"
    expect(page).to have_content(@event.id)
    expect(page).to have_content("/ru/admin/users/" + @event.user.id.to_s)
    expect(page).to have_content(@event.action_type)

  end
  it "check categories"  do
    click_on("Категория")
    current_path.should == "/ru/admin/categories"
    expect(page).to have_content(@category1.id)
    expect(page).to have_content(@category1.name)
    expect(page).to have_content("/ru/admin/users/" + @category1.owner.id.to_s)

  end
  it "check images"  do
    click_on("Картинка")
    current_path.should == "/ru/admin/images"
    expect(page).to have_content(@image1.id)
    expect(page).to have_content(@image1.category.name)
    expect(page).to have_content(@image1.user_id.to_s)
    expect(page).to have_content(@image1.img)
  end
end