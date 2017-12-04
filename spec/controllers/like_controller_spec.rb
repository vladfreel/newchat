require 'rails_helper'

RSpec.describe LikesController, :type => :controller do
  describe 'CREATE' do
    before(:each) do
      @user = FactoryGirl.create(:user)

      sign_in @user
    end
    let(:user) { FactoryGirl.create(:user) }
    let(:like) { FactoryGirl.attributes_for(:like) }
    it 'create like(CREATE)' do
      category = FactoryGirl.create(:category,user_id: @user.id)
      image = FactoryGirl.create(:image, user_id: @user.id, category_id: category.id)
     expect {post :create, params:{ like: FactoryGirl.attributes_for(:like), image: image, user: user}}.to change{ Like.count }.by(1) and redirect_to category_image_path(@image_cre.category.id, @image_cre.id)
    end
  end





  describe 'DELETE destroy' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      sign_in @user
      @category = FactoryGirl.create(:category,user_id: @user.id)
      @image_del = FactoryGirl.create(:image, user_id: @user.id, category_id: @category.id)
      @like = FactoryGirl.create(:like,user_id: @user.id,image_id: @image_del.id)
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
