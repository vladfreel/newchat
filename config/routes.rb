Rails.application.routes.draw do
  devise_for :users
  get 'persons/profile'

  get 'persons/profile', as: 'user_root'
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  get 'welcome/index'
  resources :categories do
    resources :images do
      resources :comments
    end
  end
  root 'welcome#index'
end
