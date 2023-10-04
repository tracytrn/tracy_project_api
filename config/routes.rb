Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :admins
      namespace :admin do
        post 'login', to: 'sessions#create'
        resources :categories
        resources :products
      end
      
      resources :customers
      namespace :customer do
        post 'login', to: 'sessions#create'
      end
      resources :categories, only: [:index, :show]
      resources :products, only: [:index, :show] 
    end
  end
end
