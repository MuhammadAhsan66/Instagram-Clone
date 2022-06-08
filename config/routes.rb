# frozen_string_literal: true

Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'log_in', sign_out: 'log_out', edit: 'profile', sign_up: 'register' }

  resources :users, only: %i[index show] do
    post :follow, to: 'follows#create', as: :follow
    delete :follow, to: 'follows#destroy', as: :unfollow
  end
  resources :posts do
    resources :photos, only: %i[create]
    resources :likes, only: %i[create destroy], shallow: true
    resources :comments, only: %i[create destroy edit upadte], shallow: true
  end
  resources :stories
end
