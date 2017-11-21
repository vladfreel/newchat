Rails.application.routes.draw do
  devise_for :users, skip: [:session, :passwords, :registration, :confirmation], controllers: { omniauth_callbacks: 'users/omniauth_callbacks',registrations: "users/registrations",passwords: 'users/passwords' ,sessions: 'users/sessions' , confirmations: 'users/confirmations' }
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users, skip: :omniauth_callbacks
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
    get 'images/upl_img'
    get 'comments/index'
    get 'images/index'
    root 'categories#index'
  end
end
