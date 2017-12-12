require 'rails_helper'
describe 'add category' do
  let(:user) { FactoryBot.create(:user) }
  it 'visit dashboard' do
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
  end
end
