Rails.application.routes.draw do
  use_doorkeeper
  devise_for :users
  namespace :api do
    namespace :v1 do
      resources :users
      resources :books
    end
  end
end
