Rails.application.routes.draw do

  devise_for :users

  concern :votable do
    post 'up' => 'votes#up'
    post 'down' => 'votes#down'
  end

  resources :questions do
    resources :answers, only: [ :create, :edit, :update ]
    resources :comments, only: [ :new, :create ]
    concerns :votable
  end

  resources :answers, only: [ :edit, :update ] do
    resources :comments, only: [ :new, :create ]
  end

  resources :tags, only: [ :index ]

  root 'questions#index'
  get 'tagged' => 'questions#tagged', :as => 'tagged'
end
