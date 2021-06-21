Rails.application.routes.draw do

  # 管理者認証
  devise_for :admins, controllers: {
    sessions: 'admin/sessions',
  }

  # 管理者機能
  namespace :admin do
    resources :users, only: [:show, :index, :update]
  end

  # ユーザー認証
  devise_for :users, controllers: {
    sessions:      'public/sessions',
    passwords:     'public/passwords',
    registrations: 'public/registrations'
  }
  devise_scope :user do
    post 'users/guest_sign_in' => 'users/sessions#guest_sign_in'
  end

  # ユーザー機能
  scope module: :public do
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
