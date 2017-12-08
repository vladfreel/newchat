require 'rails_helper'
describe "UserSignin" do
  let(:user) { FactoryBot.create(:user) }
  it "should click Все категории " do
    visit new_user_session_path
    fill_in "user_email", :with => user.email
    fill_in "user_password", :with => user.password
    click_button "Войти"

    # first
    visit new_category_path
    fill_in "category_name", :with => "category1"
    click_on("Создать")
    attach_file('image[img]', File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on("Добавить картинку")
    attach_file('image[img]', File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on("Добавить картинку")
    click_on("sub")
    page.should have_selector(:button, 'Отписаться')
    current_path.should == "/ru/categories/" + Category.last.id.to_s

    # second
    click_on("Создать категорию")
    fill_in "category_name", :with => "category2"
    click_on("Создать")
    attach_file('image[img]', File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on("Добавить картинку")
    attach_file('image[img]', File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on("Добавить картинку")
    click_on("sub")
    page.should have_selector(:button, 'Отписаться')
    current_path.should == "/ru/categories/" + Category.last.id.to_s

    # third
    click_on("Создать категорию")
    fill_in "category_name", :with => "category3"
    click_on("Создать")
    attach_file('image[img]', File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on("Добавить картинку")

    attach_file('image[img]', File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on("Добавить картинку")
    current_path.should == "/ru/categories/" + Category.last.id.to_s

    click_on("Главная")
    find('#dLabel1').click
    sleep 5
    page.should have_selector(:button, 'category1')
    page.should have_selector(:button, 'category2')
    page.should have_selector(:button, 'category3')
  end
end