Rails.application.routes.draw do
  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    devise_for :users
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
