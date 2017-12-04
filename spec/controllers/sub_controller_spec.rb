require 'rails_helper'

RSpec.describe SubsController, :type => :controller do
  describe 'CREATE' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @category = FactoryGirl.create(:category,user_id: @user.id)
      sign_in @user
    end
    let(:user) { FactoryGirl.create(:user) }
    let(:sub) { FactoryGirl.attributes_for(:sub) }
    it 'create image(CREATE)' do
      expect{ post :create, params: {sub: FactoryGirl.attributes_for(:sub),
                                     category_id: @category.id,
                                     user_id: @user.id
      }
      }.to change{ Sub.count }.by(1) and redirect_to @category
    end
  end
  describe 'DELETE destroy' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @category = FactoryGirl.create(:category,user_id: @user.id)
      @sub = FactoryGirl.create(:sub,user_id: @user.id,category_id: @category.id)
    end

    it 'deletes the subscribe' do
      expect{delete :destroy, params: {category_id: @category.id ,id: @sub.id} }.to change(Sub,:count).by(-1)
    end

    it 'redirects to categories#index' do
      delete :destroy, params: {category_id: @category.id, id: @sub.id}
      response.should redirect_to @category
    end
  end
end
