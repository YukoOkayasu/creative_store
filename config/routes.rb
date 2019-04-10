Rails.application.routes.draw do
  devise_for :users
  root 'products#index'
  resources :products, only: [:index, :show] do
    resources :favorites, only: [:create, :destroy]
    collection do
      get 'search'
      get 'category'
      get 'buy_confirm'
      patch 'buy'

    end
  end
  resources :users, only: [:show, :edit, :update] do
    collection do
      get 'history'
      get 'order_history'
      get 'about'
      get 'news'
      get 'add_card'
      get 'card_form'
      get 'edit_user'
      patch 'card_form' => 'users#card_save'
      delete 'card_form/:id' => 'users#card_delete'
    end
  end

  resources :carts, only: [:show] do
    collection do
      patch 'add_item'
      post 'add_item'
      post 'update_item'
      delete 'delete_item'
    end
  end
end
