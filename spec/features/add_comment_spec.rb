require 'rails_helper'
describe 'UserSignin' do
  let(:user) { FactoryBot.create(:user) }
  it 'should add comment ' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Войти'
    visit new_category_path
    fill_in 'category_name', with: 'category'
    click_on('Создать')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    expect(Image.count).to eq(1)
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    click_on('Главная')
    click_link('pic', visible: false)
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s + '/images/' + Image.last.id.to_s
    fill_in 'com_com_email', with: 'category1'
    fill_in 'com_body', with: 'category2'
    click_button('Создать коммент')
    expect(Comment.count).to eq(1)
    expect(current_path) == '/ru' + category_image_path(category_id: Category.last.id.to_s, id: Image.last.id.to_s)
  end
end
