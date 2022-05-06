Rails.application.routes.draw do
  root 'pages#home'
  devise_for :users,
             path: '',
             path_names: { sign_in: 'log_in', sign_out: 'log_out', edit: 'profile', sign_up: 'registration' }

  resources :users, only: [:show]
end

