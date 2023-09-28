Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :admins
      namespace :admins do
        post 'login', to: 'sessions#create'
      end
      
      resources :customers
      namespace :customers do
        post 'login', to: 'sessions#create'
      end
    end
  end
end
