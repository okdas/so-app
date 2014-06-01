Rails.application.routes.draw do

  devise_for :users
  resources :questions do
    resources :answers, only: [ :create, :edit, :update ]
    resources :comments, only: [ :new, :create ]
    resources :votes, only: [ :up, :down ]
  end

  resources :answers, only: [ :edit, :update ] do
    resources :comments, only: [ :new, :create ]
  end

  resources :tags, only: [ :index ]

  root 'questions#index'
  get 'tagged' => 'questions#tagged', :as => 'tagged'
end
