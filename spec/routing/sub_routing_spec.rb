require 'rails_helper'
RSpec.describe 'routes for Categories', type: :routing do
  it do
    should route(:get,
                 '/categories/1/subs/new').to('subs#new',
                                              action: :new,
                                              category_id: 1)
  end
  it do
    should route(:post,
                 '/categories/1/subs').to('subs#create',
                                          action: :create,
                                          category_id: 1)
  end
  it do
    should route(:delete,
                 '/categories/1/subs/1').to('subs#destroy',
                                            action: :destroy,
                                            category_id: 1,
                                            id: 1)
  end
end
