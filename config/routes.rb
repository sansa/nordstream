Rails.application.routes.draw do

  namespace :admin do
    resources :movies do
      collection do
        get 'upload_sample_data'
      end

    end
    resources :customers
    resources :series
  end
  resources :homes do
    member do
      get 'favourites'
      get 'play'
    end
  end
  resources :favourites

  root "dashboard#index"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
