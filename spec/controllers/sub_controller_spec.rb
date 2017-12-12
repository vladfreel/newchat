require 'rails_helper'
RSpec.describe SubsController, type: :controller do
  before(:each) do
    @user = create(:user)
    @category = create(:category, user_id: @user.id)
    sign_in @user
  end

  describe 'CREATE' do
    it 'create subscribe(CREATE)' do
      expect do
        post :create,
             params: { sub: attributes_for(:sub,
                                           user_id: @user.id),
                       category_id: @category.id }
      end.to change { Sub.count }.by(1) and
        redirect_to @category && have_http_status(200)
    end
  end

  describe 'DELETE destroy' do
    it 'deletes the subscribe' do
      sub = create(:sub, user_id: @user.id, category_id: @category.id)
      expect do
        delete :destroy, params: { category_id: @category.id, id: sub.id }
      end.to change(Sub, :count).by(-1)
      expect(response).to have_http_status(302)
    end

    it 'redirects to category' do
      sub = create(:sub, user_id: @user.id, category_id: @category.id)
      delete :destroy, params: { category_id: @category.id, id: sub.id }
      expect(response).to redirect_to @category
      expect(response).to have_http_status(302)
    end
  end
end
