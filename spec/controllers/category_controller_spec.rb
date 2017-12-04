require 'rails_helper'
RSpec.describe CategoriesController, :type => :controller do

  describe 'NEW' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it 'should be successful(NEW)' do
      get :new
      response.should be_success
    end
  end

  describe 'CREATE' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it 'create category(CREATE)' do
      expect{ post :create,
                   params: {category: FactoryGirl.attributes_for(:category,
                                                                 user_id: @user)} }.to change{ Category.count }.by(1) and redirect_to Category.last
    end
  end

  describe 'INDEX' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it 'assigns @categories(INDEX)' do
      category = FactoryGirl.create(:category,user_id: @user.id)
      get :index
      assigns(:categories).should eq([category])
      response.should render_template :index
    end
  end

  describe 'SHOW' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
    end

    it 'assigns the requested category to @category' do
      category = FactoryGirl.create(:category,user_id: @user.id)
      get :show, params: { id: category.id }
      assigns(:category).should eq(category)
      response.should render_template :show
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @category = FactoryGirl.create(:category,user_id: @user.id)
    end

    it 'deletes the category' do
      expect{delete :destroy, params: { id: @category} }.to change(Category,:count).by(-1)
    end

    it 'redirects to categories#index' do
      delete :destroy, params: { id: @category }
      response.should redirect_to categories_url
    end
  end
end
