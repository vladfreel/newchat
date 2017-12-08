require "rails_helper"

RSpec.describe "Comment management", :type => :request do
  before(:each) do
    @user = create(:user)
    @category = create(:category,user_id: @user.id)
    @image = create(:image, user_id: @user.id, category_id: @category.id)
    sign_in @user
  end
  it "creates a Image and redirects to the Image's page" do
    get "/categories/" + @category.id.to_s + "/images/" + @image.id.to_s
    expect(response).to render_template(:show)

    post "/categories/" + @category.id.to_s + "/images/" + @image.id.to_s + "/comments", params:{ comment: attributes_for(:comment, user_id: @user.id), category_id: @category.id, image_id: @image.id }

    expect(response).to redirect_to category_image_path(@image.category_id, @image.id)

    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include(Comment.last.com_email)
  end

  it "does not render a different template" do
    get "/categories/" + @category.id.to_s + "/images/" + @image.id.to_s
    expect(response).to render_template(:show)
  end
end