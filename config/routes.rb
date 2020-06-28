Rails.application.routes.draw do
  get 'trainers/group/:number', to: 'trainers#index', default: { format: 'json' }
  get 'appointments/group/:number', to: 'appointments#index', default: { format: 'json' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
