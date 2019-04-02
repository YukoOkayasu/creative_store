Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :products, only: [:index, :show] do
    resources :favorites, only: [:create, :destroy]
    collection do
      get 'category'
      get 'buy_confirm'
      patch 'buy_confirm'
    end
  end
  resources :users, only: [:show, :edit, :update] do
    collection do
      get 'history'
      get 'about'
      get 'news'
      get 'add_card'
      get 'card_form'
      get 'edit_user'
      patch 'card_form' => 'users#card_save'
      delete 'card_form/:id' => 'users#card_delete'
    end
  end
end
