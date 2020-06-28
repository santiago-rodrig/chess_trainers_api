Rails.application.routes.draw do
  get 'trainers/group/:number', to: 'trainers#index', default: { format: 'json' }
  get 'appointments/group/:number', to: 'appointments#index', default: { format: 'json' }
  post 'login', to: 'users#login', default: { format: 'json' }
  post 'logged_in', to: 'users#logged_in', default: { format: 'json' }
  post 'appointments', to: 'appointments#create', default: { format: 'json' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
