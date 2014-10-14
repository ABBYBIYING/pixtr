require "monban/constraints/signed_in"
require "monban/constraints/signed_out"

Rails.application.routes.draw do

  constraints Monban::Constraints::SignedIn.new do
    root "dashboards#show", as: :dashboard
  end

  root "galleries#index"

  get "/sign_up" => "users#new"
  get "/sign_in" => "sessions#new"
  delete "/sign_out" => "sessions#destroy"

  resources :galleries do
    resources :images, except: [:index]
  end

  resources :images, only: [] do
    resources :comments, only: [:create]
    resource :like, only: [:create, :destroy]
  end

  resources :tags, only: [:show]
  resource :session, only: [:create]
  resources :users, only: [:create]
  resources :groups, only: [:index, :new, :create, :show, :destroy] do
    member do
      post "join" => "group_memberships#create"
      delete "leave" => "group_memberships#destroy"
    end
  end
end
