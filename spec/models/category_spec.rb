require 'rails_helper'

RSpec.describe Category, :type => :model do

  it 'validates the name ' do
    should validate_presence_of(:name)
  end
  it 'Category has many images' do
    should have_many(:images).dependent(:destroy)
  end
  it 'Category has many subscribes' do
    should have_many(:subs).dependent(:destroy)
  end
  it 'Category has many users through subscribes' do
    should have_many(:users).through(:subs).dependent(:destroy)
  end
  it 'Category belong to User(owner) by foreign key user_id' do
    should belong_to(:owner).class_name('User')
  end
  it 'accepts_nested_attributes_for Category' do
    should accept_nested_attributes_for :subs
  end
  it do
    should accept_nested_attributes_for(:subs).allow_destroy(true)
  end
  describe '#name' do
    it 'should validate presence' do
      record = Category.new
      record.name = '' # invalid state
      record.valid? # run validations
      record.errors[:name].should include("Имя категории не может быть пустым") # check for presence of error

      record.name = 'cars' # valid state
      record.valid? # run validations
      record.errors[:name].should_not include("Имя категории не может быть пустым") # check for absence of error
    end
  end
end