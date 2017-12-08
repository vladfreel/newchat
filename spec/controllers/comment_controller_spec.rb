require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  before(:each) do
    @user = create(:user)
    @category = create(:category,user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
    sign_in @user
  end
  describe 'CREATE' do
    it 'create comment(CREATE)' do
      expect do
        post :create, params:{ comment: attributes_for(:comment, user_id: @user.id), category_id: @category.id, image_id: @image.id }
      end.to change{ Comment.count }.by(1) and have_http_status(200)
    end
  end
  describe 'INDEX' do
    it 'assigns @subs(INDEX)' do
      comment = FactoryBot.create(:comment, user_id: @user.id, image_id: @image.id)
      get :index
      assigns(:comments).should eq([comment])
      response.should render_template :index
      expect(response).to have_http_status(200)
    end
  end


end
