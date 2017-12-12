require 'rails_helper'
RSpec.describe 'routes for Categories', type: :routing do
  it do
    should route(:get,
                 '/images/index').to(controller: :images,
                                     action: :index)
  end
  it do
    should route(:get,
                 '/categories/1/images/2').to('images#show',
                                              action: :show,
                                              category_id: 1,
                                              id: 2)
  end
  it do
    should route(:get,
                 '/categories/1/images/new').to('images#new',
                                                action: :new,
                                                category_id: 1)
  end
  it do
    should route(:post,
                 '/categories/1/images').to('images#create',
                                            action: :create,
                                            category_id: 1)
  end
end
