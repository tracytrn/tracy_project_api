Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :admins do
        resources :categories
      end
      namespace :admins do
        post 'login', to: 'sessions#create'
      end
      
      resources :customers do
        resources :categories 
      end
      namespace :customers do
        post 'login', to: 'sessions#create'
      end
    end
  end
end
