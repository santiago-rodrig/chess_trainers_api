Rails.application.routes.draw do
  get 'trainers/group/:number', to: 'trainers#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
