require 'rails_helper'

RSpec.describe SubsController, :type => :controller do

  describe 'CREATE' do
    before(:each) do
      @user = create(:user)
      @category = create(:category,user_id: @user.id)
    end
    it 'create subscribe(CREATE)' do
      sign_in @user
      expect do
        post :create, params:{ sub: attributes_for(:sub,user_id: @user.id), category_id: @category.id }
      end.to change{ Sub.count }.by(1) and redirect_to @category
    end

  end


  describe 'DELETE destroy' do
    before(:each) do
      @user = create(:user)
      sign_in @user
      @category = create(:category,user_id: @user.id)
      @sub = create(:sub,user_id: @user.id,category_id: @category.id)
    end

    it 'deletes the subscribe' do
      expect{delete :destroy, params: {category_id: @category.id ,id: @sub.id} }.to change(Sub,:count).by(-1)
    end

    it 'redirects to category' do
      delete :destroy, params: {category_id: @category.id, id: @sub.id}
      response.should redirect_to @category
    end
  end
end
