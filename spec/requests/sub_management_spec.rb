require "rails_helper"

RSpec.describe "Category management", :type => :request do
  before(:each) do
    @user = create(:user)
    @category = create(:category,user_id: @user.id)
    sign_in @user
  end
  it "creates a Sub and redirects to the Categorie's page" do
    get "/categories/" + @category.id.to_s
    expect(response).to render_template(:show)

    post "/categories/" + @category.id.to_s + "/subs", params:{ sub: attributes_for(:sub,user_id: @user.id), category_id: @category.id }

    expect(response).to redirect_to(assigns(:category))
    follow_redirect!

    expect(response).to render_template(:show)
    expect(response.body).to include("unsub")
  end
end