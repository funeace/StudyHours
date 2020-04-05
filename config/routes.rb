Rails.application.routes.draw do
  root 'homes#top'

  devise_for :users
  resources :users,only:[:index,:show,:edit,:update] do
    member do
      get :mypage
      get :follow
      get :follower
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