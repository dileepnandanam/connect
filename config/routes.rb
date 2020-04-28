Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: "users#index"
  resources :users do
    get :switch, on: :member
    get 'login', on: :collection
  end
  resources :responses do
    put :accept, on: :member
    put :reject, on: :member
  end

  resources :chats

end
