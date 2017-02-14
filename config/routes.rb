# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  devise_for :users
  mount Attachinary::Engine => "/attachinary"
  root to: 'products#index'

  resources :orders, only: [:show, :create] do
    resources :payments, only: [:new, :create]
  end

  resources :products, only: [:index] do
    resources :line_items, only: [:create]
  end

  namespace :admin do
    get '', to: 'products#index', as: '/'
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :edit, :destroy]
    resources :orders, only: [:index, :show]
    resources :line_items, only: [:index]
    resources :companies, only: [:index, :new, :create, :edit, :update, :destroy]
  end

end
