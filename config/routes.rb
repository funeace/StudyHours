Rails.application.routes.draw do
  root 'homes#top'
  # deviseの設定。deviseではなくuserコントローラから実装しているため、パスを直接指定する
  devise_for :users,controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  resources :users,only:[:index,:show,:edit,:update] do
    member do
      get :detail
      get :following
      get :followers
    end
  end
  resources :relationships, only: [:create,:destroy]
  resources :records,only: [:show,:new,:create,:edit,:update,:destroy] do
    resource :record_comments, only: [:create,:destroy]
    resource :record_favorites, only: [:create,:destroy]
  end
  resources :notes,only: [:show,:new,:create,:edit,:update,:destroy] do
    resource :note_comments, only: [:create,:destroy]
    resource :note_favorites, only: [:create,:destroy]
  end
  resources :lists,only: [:index] do
    collection do
      get :search
    end
  end
end