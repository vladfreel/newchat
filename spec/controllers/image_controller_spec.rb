require 'rails_helper'

RSpec.describe ImagesController, :type => :controller do

  describe 'CREATE' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @category = FactoryGirl.create(:category,user_id: @user.id)
      sign_in @user
    end
    let(:user) { FactoryGirl.create(:user) }
    let(:image) { FactoryGirl.attributes_for(:image) }
    it 'create image(CREATE)' do
      expect{ post :create, params: {image: FactoryGirl.attributes_for(:image),
                                     category_id: @category.id,
                                     user_id: @user.id
                                     }
      }.to change{ Image.count }.by(1) and redirect_to @category
    end
  end
  describe 'INDEX' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @category = FactoryGirl.create(:category,user_id: @user.id)
      sign_in @user
    end

    it 'assigns @images(INDEX)' do
      image = FactoryGirl.create(:image,
                                 user_id: @user.id,
                                 category_id: @category.id,
                                 )
      get :index
      assigns(:images).should eq([image])
      response.should render_template :index
    end
  end

  describe 'SHOW' do
    before(:each) do
      @user = FactoryGirl.create(:user)
      @category = FactoryGirl.create(:category,user_id: @user.id)
      sign_in @user
    end

    it 'assigns the requested image to @image' do
      image = FactoryGirl.create(:image,
                                 user_id: @user.id,
                                 category_id: @category.id,
                                 )
      get :show, params: { category_id: @category.id, id: image.id }
      assigns(:image).should eq(image)
      response.should render_template :show
    end
  end

end
