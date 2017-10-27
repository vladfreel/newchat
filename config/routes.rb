Rails.application.routes.draw do
  get 'welcome/index'
  resources :categories do
    resources :images do
      resources :comments
    end
  end
  root 'welcome#index'
end
