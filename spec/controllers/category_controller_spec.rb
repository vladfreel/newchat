require 'rails_helper'
RSpec.describe CategoriesController, type: :controller do
  before(:each) do
    @user = create(:user)
    sign_in @user
  end
  describe 'NEW' do
    it 'should be successful(NEW)' do
      get :new
      expect(response).to be_success
      expect(response).to have_http_status(200)
    end
  end

  describe 'CREATE' do
    it 'create category(CREATE)' do
      expect do
        post :create,
             params: { category: attributes_for(:category,
                                                user_id: @user) }
      end.to change { Category.count }.by(1) and
        redirect_to Category.last && have_http_status(200)
    end
  end

  describe 'INDEX' do
    it 'assigns @categories' do
      category = create(:category, user_id: @user.id)
      get :index
      expect(assigns(:categories)).to eq([category])
      expect(response).to have_http_status(200)
    end

    it 'renders the index template' do
      get :index
      expect(response).to render_template('index')
      expect(response).to have_http_status(200)
    end
  end

  describe 'SHOW' do
    it 'assigns the requested category to @category' do
      category = create(:category, user_id: @user.id)
      get :show, params: { id: category.id }
      expect(assigns(:category)).to eq(category)
      expect(response).to render_template(:show)
      expect(response).to have_http_status(200)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the category' do
      category = create(:category, user_id: @user.id)
      expect do
        delete :destroy, params: { id: category }
      end.to change(Category, :count).by(-1)
      expect(response).to have_http_status(302)
    end

    it 'redirects to categories#index' do
      category = create(:category, user_id: @user.id)
      delete :destroy, params: { id: category }
      expect(response).to redirect_to categories_url
      expect(response).to have_http_status(302)
    end
  end
end
