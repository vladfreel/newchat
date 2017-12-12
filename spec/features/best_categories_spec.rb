require 'rails_helper'
describe 'UserSignin' do
  let(:user) { FactoryBot.create(:user) }
  it 'should click Главная -> Топ 5 категорий  ' do
    visit new_user_session_path
    fill_in 'user_email', with: user.email
    fill_in 'user_password', with: user.password
    click_button 'Войти'
    # first
    visit new_category_path
    fill_in 'category_name', with: 'category1'
    click_on('Создать')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    # second
    click_on('Создать категорию')
    fill_in 'category_name', with: 'category2'
    click_on('Создать')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    # third
    click_on('Создать категорию')
    fill_in 'category_name', with: 'category3'
    click_on('Создать')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    # fourth
    click_on('Создать категорию')
    fill_in 'category_name', with: 'category4'
    click_on('Создать')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    # fifth
    click_on('Создать категорию')
    fill_in 'category_name', with: 'category5'
    click_on('Создать')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    # sixth
    click_on('Создать категорию')
    fill_in 'category_name', with: 'category6'
    click_on('Создать')
    attach_file('image[img]',
                File.join(Rails.root, '/spec/fixtures/doska12.jpg'))
    click_on('Добавить картинку')
    expect(current_path) == '/ru/categories/' + Category.last.id.to_s
    click_on('Главная')
    find('#dLabel2').click
    expect(page).to have_no_content('category6')
  end
end
