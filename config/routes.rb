Rails.application.routes.draw do

  devise_for :users,skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  scope module: :public do
    root to: "homes#top"
    get "/about" => "homes#about", as: "about"
    resources :users, only: [:show, :edit, :update, :destroy]
    resources :logs, only: [:new, :index, :show, :create, :edit, :update, :destroy]
  end
  namespace :admin do
    resources :users, only: [:index, :show, :edit, :update]
    resources :logs, only: [:index, :show, :destroy]
  end
  
end
