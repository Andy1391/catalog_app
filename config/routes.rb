Rails.application.routes.draw do
  
  root 'api/v1/catalog#index'
  use_doorkeeper
    # skip_controller :authorizations, :applications, :authorized_applications
  devise_for :users
  namespace :api do
    namespace :v1 do
      get 'catalog/index'
      post 'users/sign_in'
      get '/users/me'      
      resources :users
      resources :books
    end
  end  
end
