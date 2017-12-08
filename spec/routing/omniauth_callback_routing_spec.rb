require 'rails_helper'

RSpec.describe "routes for Omniauth", :type => :routing do
  it do
    should route(:post, '/users/auth/twitter').
        to(controller: "users/omniauth_callbacks", action: :passthru)
  end
end