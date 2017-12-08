require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do

  describe 'CREATE' do
    before(:each) do
      @user = create(:user)
      @category = create(:category,user_id: @user.id)
      @image = create(:image, user_id: @user.id, category_id: @category.id)

    end
    it 'create comment(CREATE)' do
      sign_in @user
      expect do
        post :create, params:{ comment: attributes_for(:comment, user_id: @user.id), category_id: @category.id, image_id: @image.id }
      end.to change{ Comment.count }.by(1)
    end
  end
  describe 'INDEX' do
    before(:each) do
      @user = create(:user)
      @image = create(:category,user_id: @user.id)
    end

    it 'assigns @subs(INDEX)' do
      sign_in @user
      category = FactoryBot.create(:category,user_id: @user.id)
      image = FactoryBot.create(:image, user_id: @user.id, category_id: category.id)
      comment = FactoryBot.create(:comment, user_id: @user.id, image_id: image.id)
      get :index
      assigns(:comments).should eq([comment])
      response.should render_template :index
    end
  end


end
