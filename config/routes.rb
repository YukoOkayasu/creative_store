Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :products, only: [:index, :show] do
    resources :favorites, only: [:create, :destroy]
    collection do
      get 'category'
    end
  end
  resources :users, only: [:show] do
    collection do
      get 'about'
      get 'news'
    end
  end
end
