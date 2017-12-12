require 'rails_helper'
RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  context 'with valid google credentials' do
    # this should actually be created in a factory
    let(:provider) { :twitter }
    let(:oauth) do
      OmniAuth::AuthHash.new provider: provider,
                             uid: '1234',
                             info: { nickname: 'foobar2',
                                     login: 'foobar',
                                     avatar: 'foo',
                                     password: 'password' }
    end

    before do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[provider] = oauth
    end

    it 'creates a new user' do
      expect { visit '/users/auth/twitter' }.to change(User, :count).by(1)
    end
  end
end
