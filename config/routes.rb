Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'log_in', sign_out: 'log_out', edit: 'profile', sign_up: 'register' }

  resources :users, only: %i[show]
  resources :posts do
    resources :photos, only: %i[create]
    resources :likes, only: %i[create destroy], shallow: true
  end
end
