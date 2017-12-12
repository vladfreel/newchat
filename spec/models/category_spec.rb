require 'rails_helper'
RSpec.describe Category, type: :model do
  it 'validates the name ' do
    expect(subject).to validate_presence_of(:name)
  end
  it 'Category has many images' do
    expect(subject).to have_many(:images).dependent(:destroy)
  end
  it 'Category has many subscribes' do
    expect(subject).to have_many(:subs).dependent(:destroy)
  end
  it 'Category has many users through subscribes' do
    expect(subject).to have_many(:users).through(:subs).dependent(:destroy)
  end
  it 'Category belong to User(owner) by foreign key user_id' do
    expect(subject).to belong_to(:owner).class_name('User')
  end
  it 'accepts_nested_attributes_for Category' do
    expect(subject).to accept_nested_attributes_for :subs
  end
  it do
    expect(subject).to accept_nested_attributes_for(:subs).allow_destroy(true)
  end
  describe '#name' do
    it 'should validate presence' do
      record = Category.new
      record.name = '' # invalid state
      record.valid? # run validations
      expect(record.errors[:name]).to include('Имя категории не может быть пустым')
      record.name = 'cars' # valid state
      record.valid? # run validations
      expect(record.errors[:name]).not_to include('Имя категории не может быть пустым')
    end
  end
end
