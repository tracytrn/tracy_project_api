Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      resources :admins, path: '/admins' do
        collection do
          post 'login', to: 'sessions#create'
        end
      end
      resources :customers, path: '/customers' do
        collection do
          post 'login', to: 'sessions#create'
        end
      end
    end
  end
end
