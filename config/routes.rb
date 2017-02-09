# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users
  mount Attachinary::Engine => "/attachinary"
  root to: 'pages#home'

  resources :products, only: [:index]

  # namespace :admin do
  #   get '', to: 'products#index', as: '/'
  # end
  namespace :admin do
    get '', to: 'products#index', as: '/'
    resources :products, only: [:show, :new, :create, :edit, :update, :destroy]
  end
end
