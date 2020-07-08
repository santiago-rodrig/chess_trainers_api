Rails.application.routes.draw do
  get 'trainers/group/:number', to: 'trainers#index', default: { format: 'json' }
  get 'appointments/group/:number', to: 'appointments#index', default: { format: 'json' }
  post 'login', to: 'users#login', default: { format: 'json' }
  get 'logged_in', to: 'users#logged_in', default: { format: 'json' }
  post 'appointments', to: 'appointments#create', default: { format: 'json' }
  post 'users', to: 'users#create', default: { format: 'json' }
  delete 'logout', to: 'users#logout', default: { format: 'json' }
  get 'user', to: 'users#show', default: { format: 'json' }
  put 'users/update', to: 'users#update', default: { format: 'json' }
end
