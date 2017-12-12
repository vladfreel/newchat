require 'rails_helper'
RSpec.describe 'Like management', type: :request do
  before(:each) do
    @user = create(:user)
    @category = create(:category, user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
    sign_in @user
  end
  it 'creates a Like and redirects to the Like page' do
    get '/categories/' + @category.id.to_s + '/images/' + @image.id.to_s
    expect(response).to render_template(:show)
    path = '/categories/' + @category.id.to_s + '/images/' + @image.id.to_s + '/likes'
    post path, params: { like: attributes_for(:like,
                                              user_id: @user.id),
                         category_id: @category.id,
                         image_id: @image.id }

    expect(response).to redirect_to category_image_path(@image.category_id,
                                                        @image.id)
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include('dislike')
  end

  it 'does not render a different template' do
    get '/categories/' + @category.id.to_s + '/images/' + @image.id.to_s
    expect(response).to render_template(:show)
  end
end
