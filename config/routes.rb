Rails.application.routes.draw do

  scope module: :admin do
    devise_for :admins, controllers: {
      sessions:      'admin/admins/sessions',
      passwords:     'admin/admins/passwords',
    }
  end

  namespace :admin do
    resources :users, only: [:show, :index, :update]
  end

  scope module: :public do
    devise_for :users, controllers: {
      sessions:      'public/users/sessions',
      passwords:     'public/users/passwords',
      registrations: 'public/users/registrations'
    }
    devise_scope :user do
      post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
    end

    root 'homes#top'
    get 'home' => 'homes#home'
    get '/post/hashtag/:name' => 'posts#hashtag'
    get 'search' => 'searches#search'
    get 'users/unsubscribe' => 'users#unsubscribe', as: 'confirm_unsubscribe'
    patch 'users/withdraw' => 'users#withdraw', as: 'withdraw_user'
    put 'users/withdraw' => 'users#withdraw'
    resources :notifications, only: :index
    resources :users, only: [:show, :index, :edit, :update] do
      resource :relationships, only: [:create, :destroy]
    	get 'followings' => 'relationships#followings', as: 'followings'
    	get 'followers' => 'relationships#followers', as: 'followers'
    	get :favorites, on: :member
    end
    resources :posts do
      resource  :likes, only: [:create, :destroy]
      resource  :favorites, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end
  end
end
