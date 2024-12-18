Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  devise_scope :user do
    post 'users/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    get "users/unsubscribe" => "users#unsubscribe"
    patch "users/withdraw" => "users#withdraw"
    get '/search', to: 'searches#search'
    resources :users, only: [:show, :edit, :update, :destroy] do
      resource :relationships, only: [:create, :destroy]
      get 'followings' => 'relationships#followings', as: 'followings'
      get 'followers' => 'relationships#followers', as: 'followers'
    end
    resources :logs, only: [:new, :index, :show, :create, :edit, :update, :destroy] do
      resource :favorites, only: [:create, :destroy]
      resources :log_comments, only: [:create, :destroy]
    end
  end
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :logs, only: [:index, :show, :destroy]
  end
  
end
