Rails.application.routes.draw do
  root 'homes#top'
  # deviseの設定。deviseではなくuserコントローラから実装しているため、パスを直接指定する
  devise_for :users,controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    omniauth_callbacks: 'users/omniauth_callbacks',
    passwords: 'users/passwords'
  }
  
  resources :users,only:[:index,:show,:edit,:update] do
    member do
      get :detail
      get :following
      get :followers
      get :favorites
    end
  end
  resources :relationships, only: [:create,:destroy]
  resources :study_logs,only: [:show,:new,:create,:edit,:update,:destroy] do
    resources :study_log_comments, only: [:create,:destroy]
    resource :study_log_favorites, only: [:create,:destroy]
    collection do
      get :modal_study_log_new
    end
  end
  resources :notes,only: [:show,:new,:create,:edit,:update,:destroy] do
    resources :note_comments, only: [:create,:destroy]
    resource :note_favorites, only: [:create,:destroy]
    collection do
      get :preview
     end
  end
  resources :searchs,only: [:index] do
    collection do
      get :sort
      get :search
    end
  end
  resources :timelines,only: [:index]
  resources :rooms,only:[:index,:show,:create] do
    collection do
      get :search
    end
  end
  resources :notifications, only: [:index]
end