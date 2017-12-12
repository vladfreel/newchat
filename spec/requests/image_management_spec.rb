require 'rails_helper'
RSpec.describe 'Category management', type: :request do
  before(:each) do
    @user = create(:user)
    @category = create(:category, user_id: @user.id)
    sign_in @user
  end
  it 'creates a Image and redirects to the Image page' do
    get '/categories/' + @category.id.to_s
    expect(response).to render_template(:show)
    post '/categories/' + @category.id.to_s + '/images',
         params: { image: attributes_for(:image),
                   category_id: @category.id,
                   user_id: @user.id }
    expect(response).to redirect_to(assigns(:category))
    follow_redirect!
    expect(response).to render_template(:show)
    expect(response.body).to include('pic')
  end

  it 'does not render a different template' do
    get '/categories/' + @category.id.to_s + '/images'
    expect(response).to_not render_template(:show)
  end
end
