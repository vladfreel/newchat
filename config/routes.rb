Rails.application.routes.draw do
  devise_for :users, :controllers => {
    omniauth_callbacks: 'users/omniauth_callbacks',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    sessions: 'users/sessions',
    confirmations: 'users/confirmations'
  }
  resources :users
  scope '(:locale)', locale: /#{I18n.available_locales.join('|')}/ do

    devise_scope :user do
      get '/confirmation-getting-started' => 'users/registrations#getting_started', as: 'confirmation_getting_started'
      get '/users/auth/:provider' => 'users/omniauth_callbacks#passthru'
    end
    get 'persons/profile'
    get 'persons/profile', as: 'user_root'
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    resources :events
    resources :categories do
      resources :subs
      resources :images do
        resources :comments
        resources :likes
      end
    end
    get 'images/upl_img'
    get 'comments/index'
    get 'images/index'
    root 'categories#index'
  end
end
