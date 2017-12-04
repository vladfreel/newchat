require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do
  describe 'CREATE' do
    before(:each) do
      @user = FactoryGirl.create(:user)

      sign_in @user
    end
    let(:user) { FactoryGirl.create(:user) }
    let(:category) { FactoryGirl.create(:category) }
    let(:image) { FactoryGirl.create(:image) }
    let(:comment) { FactoryGirl.attributes_for(:comment) }
    it 'create comment(CREATE)' do
      category = FactoryGirl.create(:category,user_id: @user.id)
      image = FactoryGirl.create(:image, user_id: @user.id, category_id: category.id)
      expect {post :create, params:{ comment: FactoryGirl.attributes_for(:comment), image_id: image.id, user: user}}.to change{ Comment.count }.by(1) and redirect_to category_image_path(@image_cre.category.id, @image_cre.id)
    end
  end
  describe 'INDEX' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @category = FactoryGirl.create(:category,user_id: @user.id)
      sign_in @user
    end

    it 'assigns @categories(INDEX)' do
      sub = FactoryGirl.create(:sub, user_id: @user.id, category_id: @category.id)
      get :index
      assigns(:subs).should eq([sub])
      response.should render_template :index
    end
  end


end
