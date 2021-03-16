Rails.application.routes.draw do
  
  devise_for :admin_users
  root 'home#index'   
  use_doorkeeper
    # skip_controller :authorizations, :applications, :authorized_applications
  devise_for :users
    namespace :api do
      namespace :v1 do        
        get 'catalog/index'
        post 'users/sign_in'
        post 'users/sign_up'
        post 'users/log_out'
        get 'users/me'
        resources :charges, only: [:new, :create]
        resources :order_item, only: [:create, :destroy]
        resources :orders
        resources :users
        resources :books
        resources :authors
        resources :categories
      end
    end

    namespace :admin do
      get 'sales/index'
      get 'dashboards/index'
      get 'dashboards/index2'
      get 'dashboards/index3'
      get 'dashboards/index4'
      get 'dashboards/index3_data'
      post 'dashboards/index3_month'
      get 'dashboards/index4_data'
      get 'catalog/index'
      post 'users/sign_in'
      post 'users/sign_up'
      post 'users/log_out'
      get 'users/me'
      resources :charges, only: [:new, :create]
      resources :order_item, only: [:create, :destroy]
      resources :orders
      resources :users
      resources :books
      resources :authors
      resources :categories
      resources :admin_users
    end    
end
