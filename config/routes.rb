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
  resources :study_logs,only: [:show,:new,:create,:edit,:update,:destroy] do
    resource :study_log_comments, only: [:create,:destroy]
    resource :study_log_favorites, only: [:create,:destroy]
  end
  resources :notes,only: [:show,:new,:create,:edit,:update,:destroy] do
    resource :note_comments, only: [:create,:destroy]
    resource :note_favorites, only: [:create,:destroy]
  end
  resources :searchs,only: [:index]
  resources :timelines,only: [:index]
  resources :rooms
end