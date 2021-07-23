Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      get '/merchants/find', to: 'merchants#find'
      resources :merchants, only: [:index, :show], controller: 'merchants' do
        resources :items, only: [:index], controller: :merchant_items
      end
      get '/items/find_all', to: 'items#find'
      resources :items do 
        resources :merchant, only: [:index], controller: :items_merchant
        collection do
          get 'find', to: 'items#find'
        end
      end
    end
  end
end
