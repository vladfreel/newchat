require 'rails_helper'

RSpec.describe LikesController, :type => :controller do

  describe 'CREATE' do
    before(:each) do
      @user = create(:user)
      @category = create(:category,user_id: @user.id)
      @image = create(:image, user_id: @user.id, category_id: @category.id)

    end
    it 'create like(CREATE)' do
      sign_in @user
      expect do
        post :create, params:{ like: attributes_for(:like,
                                                    user_id: @user.id), category_id: @category.id, image_id: @image.id }
      end.to change{ Like.count }.by(1)
    end
  end

  describe 'DELETE destroy' do
    before(:each) do
      @user = create(:user)
      sign_in @user
      @category = create(:category,user_id: @user.id)
      @image_del = create(:image, user_id: @user.id, category_id: @category.id)
      @like = create(:like,user_id: @user.id,image_id: @image_del.id)
    end

    it 'deletes the category' do
      expect{delete :destroy, params: {category_id: @category.id ,image_id: @image_del.id ,id: @like.id} }.to change(Like,:count).by(-1)
    end

    it 'redirects to categories#index' do
      delete :destroy, params: {category_id: @category.id ,image_id: @image_del.id ,id: @like.id}
      response.should redirect_to category_image_path(@category.id, @image_del.id)
    end
  end
end
