Rails.application.routes.draw do

  scope module: :admin do
    devise_for :admins, controllers: {
      sessions:      'admin/admins/sessions',
      passwords:     'admin/admins/passwords',
      registrations: 'admin/admins/registrations'
    }
  end

  scope module: :public do
    devise_for :users, controllers: {
      sessions:      'public/users/sessions',
      passwords:     'public/users/passwords',
      registrations: 'public/users/registrations'
    }
    root 'homes#top'
    get 'home' => 'homes#home'
    get '/post/hashtag/:name' => 'posts#hashtag'
    get 'search' => 'searches#search'
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
