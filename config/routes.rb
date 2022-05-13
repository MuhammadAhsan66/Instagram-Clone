Rails.application.routes.draw do
  root 'posts#index'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'log_in', sign_out: 'log_out', edit: 'profile', sign_up: 'registration' }

  resources :users, only: [:show]
  resources :posts, only: %i[index show create] do
    resources :photos, only: %i[create]
  end
end
