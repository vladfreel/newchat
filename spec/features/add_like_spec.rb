require 'rails_helper'
describe 'UserSignin' do
  let(:user) { FactoryBot.create(:user) }
  before(:each) do
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
  end
  it 'should click Like ' do
    click_on('like')
    expect(Like.count).to eq(1)
  end
  it 'should click DisLike ' do
    click_on('like')
    expect(Like.count).to eq(1)
    click_on('dislike')
    expect(Like.count).to eq(0)
  end
end
