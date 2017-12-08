require 'rails_helper'

RSpec.describe "routes for Categories", :type => :routing do

        it do
          should route(:get, '/categories').
            to(controller: :categories, action: :index)
        end
        it do
          should route(:get, '/categories/1').
            to('categories#show',action: :show, id: 1)
        end
        it do
          should route(:get, '/categories/new').
              to('categories#new',action: :new)
        end
        it do
          should route(:post, '/categories').
              to('categories#create',action: :create)
        end
        it do
          should route(:delete, '/categories/1').
              to('categories#destroy',action: :destroy,id: 1)
        end
end