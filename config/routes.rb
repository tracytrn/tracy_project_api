Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :admins
      namespace :admin do
        post 'login', to: 'sessions#create'
        resources :categories do
          member do
            get 'products', to: 'categories#products'
          end
        end
        resources :products
      end
      
      resources :customers
      namespace :customer do
        post 'login', to: 'sessions#create'
      end
      resources :categories, only: [:index, :show] do
        member do
          get 'products', to: 'categories#products'
        end
      end
      resources :products, only: [:index, :show] 
    end
  end
end
