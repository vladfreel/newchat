require 'rails_helper'
RSpec.describe LikesController, type: :controller do
  before(:each) do
    @user = create(:user)
    @category = create(:category,
                       user_id: @user.id)
    @image = create(:image,
                    user_id: @user.id,
                    category_id: @category.id)
    sign_in @user
  end

  describe 'CREATE' do
    it 'create like(CREATE)' do
      expect do
        post :create,
             params: { like: attributes_for(:like,
                                            user_id: @user.id),
                       category_id: @category.id,
                       image_id: @image.id }
      end.to change { Like.count }.by(1) and have_http_status(200)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the category' do
      like = create(:like, user_id: @user.id, image_id: @image.id)
      expect do
        delete :destroy,
               params: { category_id: @category.id,
                         image_id: @image.id,
                         id: like.id }
      end.to change(Like, :count).by(-1)
      expect(response).to have_http_status(302)
    end

    it 'redirects to categories#index' do
      like = create(:like,
                    user_id: @user.id,
                    image_id: @image.id)
      delete :destroy, params: { category_id: @category.id,
                                 image_id: @image.id,
                                 id: like.id }
      expect(response).to redirect_to category_image_path(@category.id,
                                                          @image.id)
      expect(response).to have_http_status(302)
    end
  end
end
