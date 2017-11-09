Rails.application.routes.draw do
  devise_for :users, skip: [:session, :password, :registration, :confirmation], controllers: { omniauth_callbacks: 'omniauth_callbacks', registrations:  "my_registrations" ,sessions: 'users/sessions' }
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, skip: :omniauth_callbacks, :controllers => {passwords: "passwords"}
    devise_scope :user do
      get 'auth/:provider/setup' => 'omniauth_callbacks#setup'
    end
    get 'persons/profile'

    get 'persons/profile', as: 'user_root'
    devise_for :admin_users, ActiveAdmin::Devise.config
    ActiveAdmin.routes(self)
    get 'welcome/index'
    resources :events

    resources :categories do
      resources :subs
      resources :images do
        resources :comments
        resources :likes
      end
    end
    get 'comments/index'
    get 'images/index'
    root 'welcome#index'
  end
end
