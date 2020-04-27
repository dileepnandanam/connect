Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#index"
  resources :users do
    get 'login', on: :collection
  end
  resources :responses
  get '/:id', to: 'users#create'
end
