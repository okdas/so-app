Rails.application.routes.draw do

  use_doorkeeper
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
    concerns :votable
  end

  resources :tags, only: [ :index ]

  root 'questions#index'
  get 'tagged' => 'questions#tagged', :as => 'tagged'

  namespace 'api' do
    namespace 'v1' do
      resource :profiles do
        get :me, on: :collection
        get :index, on: :collection
      end

      resource :questions do
        get :index, on: :collection
      end
    end
  end
end
