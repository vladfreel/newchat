require 'rails_helper'
describe 'UserSignin' do
  let(:user) { create(:user) }
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
    fill_in 'com_com_email', with: 'category'
    fill_in 'com_body', with: 'category'
    click_on('Создать коммент')
    expect(Comment.count).to eq(1)
  end

  it 'should click Профиль ' do
    click_on('Главная')
    click_link('edit', visible: false)
    expect(current_path) == '/users/edit'
  end

  it 'should click EN ' do
    click_on('Главная')
    click_on('loc_en')
    expect(current_path) == '/en/categories'
  end

  it 'should click RU ' do
    click_on('Главная')
    click_on('loc_en')
    click_on('loc_ru')
    expect(current_path) == '/ru/categories'
  end

  it 'should click Главная ' do
    click_on('Главная')
    expect(current_path) == '/ru/categories'
  end

  it 'should click Главная -> Картинка ' do
    click_on('Главная')
    click_link('pic', visible: false)
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s + '/images/' + Image.last.id.to_s
  end

  it 'should click Главная -> Все картинки ' do
    click_on('Главная')
    click_on('Все картинки')
    expect(current_path) == '/ru/images/index'
  end

  it 'should click Главная -> Все картинки -> Картинка' do
    click_on('Главная')
    click_on('Все картинки')
    expect(current_path) == '/ru/images/index'
    click_link('pic', visible: false)
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s + '/images/' + Image.last.id.to_s
  end

  it 'should click Главная -> Все комментарии ' do
    click_on('Главная')
    click_on('Все комментарии')
    expect(current_path) == '/ru/comments/index'
  end

  it 'should click Главная -> Все комментарии -> К картинке' do
    click_on('Главная')
    click_on('Все комментарии')
    expect(current_path) == '/ru/comments/index'
    click_link('pic')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s + '/images/' + Image.last.id.to_s
  end
  it 'should click Главная -> Все комментарии -> К картинке -> Лайк' do
    click_on('Главная')
    click_on('Все комментарии')
    expect(current_path) == '/ru/comments/index'
    click_link('pic')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s + '/images/' + Image.last.id.to_s
    click_on('like')
    expect(Like.count).to eq(1)
    click_on('dislike')
    expect(Like.count).to eq(0)
  end
  it 'should click Главная -> Все комментарии -> К картинке -> Коммент' do
    click_on('Главная')
    click_on('Все комментарии')
    expect(current_path) == '/ru/comments/index'
    click_link('pic')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s + '/images/' + Image.last.id.to_s
    fill_in 'com_com_email', with: 'category'
    fill_in 'com_body', with: 'category'
    click_on('Создать коммент')
    expect(Comment.count).to eq(2)
  end
end
