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
  end

  it 'should click Главная -> Подписанные категории -> Категория ' do
    click_on('sub')
    click_on('Главная')
    find('#dLabel3').click
    click_on('cat')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
  end
  it 'should click Главная -> Подписанные категории -> Категория ' do
    click_on('sub')
    click_on('Главная')
    find('#dLabel3').click
    click_on('cat')
    click_on('unsub')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
  end
  it 'should click Главная -> Топ 5 категорий -> Категория ' do
    click_on('Главная')
    find('#dLabel2').click
    click_on('category')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
  end
  it 'should click Главная -> Все категории -> Категория ' do
    click_on('Главная')
    find('#dLabel1').click
    click_on('category')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
  end
  it 'should click Главная -> Топ 5 категорий -> Категория -> Картинка ' do
    click_on('Главная')
    find('#dLabel2').click
    click_on('category')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    expect(Image.count).to eq(1)
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    click_link('pic', visible: false)
  end
  it 'should click Главная -> Все категории -> Категория -> Картинка' do
    click_on('Главная')
    find('#dLabel1').click
    click_on('category')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    expect(Image.count).to eq(1)
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    click_link('pic', visible: false)
  end
end
