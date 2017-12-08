require 'rails_helper'

RSpec.describe ImagesController, :type => :controller do

  before(:each) do
    @user = create(:user)
    @category = create(:category,user_id: @user.id)
    sign_in @user
  end

  describe 'CREATE' do
    let(:image) { attributes_for(:image) }
    it 'create image(CREATE)' do
      expect{ post :create, params: {image: attributes_for(:image), category_id: @category.id, user_id: @user.id}
      }.to change{ Image.count }.by(1) and redirect_to @category and have_http_status(200)
    end
  end

  describe 'INDEX' do
    it 'assigns @images(INDEX)' do
      image = create(:image, user_id: @user.id, category_id: @category.id)
      get :index
      assigns(:images).should eq([image])
      response.should render_template :index
      expect(response).to have_http_status(200)
    end
  end

  describe 'SHOW' do
    it 'assigns the requested image to @image' do
      image = create(:image, user_id: @user.id, category_id: @category.id)
      get :show, params: { category_id: @category.id, id: image.id }
      assigns(:image).should eq(image)
      response.should render_template :show
      expect(response).to have_http_status(200)
    end
  end

end
