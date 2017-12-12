require 'rails_helper'
RSpec.describe 'routes for Categories', type: :routing do
  it do
    should route(:get,
                 '/comments/index').to(controller: :comments,
                                       action: :index)
  end
  it do
    should route(:get,
                 '/categories/1/images/1/comments/new').to('comments#new',
                                                           action: :new,
                                                           category_id: 1,
                                                           image_id: 1)
  end
  it do
    should route(:post,
                 '/categories/1/images/1/comments').to('comments#create',
                                                       action: :create,
                                                       category_id: 1,
                                                       image_id: 1)
  end
end
