require 'rails_helper'
RSpec.describe 'routes for Categories', type: :routing do
  it do
    expect(get: '/categories').to route_to(controller: 'categories',
                                           action: 'index')
  end
  it do
    expect(get: '/categories/1').to route_to(controller: 'categories',
                                             action: 'show',
                                             id: '1')
  end
  it do
    expect(get: '/categories/new').to route_to(controller: 'categories',
                                               action: 'new')
  end
  it do
    expect(post: '/categories').to route_to(controller: 'categories',
                                            action: 'create')
  end
  it do
    expect(delete: '/categories/1').to route_to(controller: 'categories',
                                                action: 'destroy', id: '1')
  end
end
