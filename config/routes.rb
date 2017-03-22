# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  get 'menu_items/create'

  devise_for :users
  mount Attachinary::Engine => "/attachinary"
  root to: 'menus#index'

  resources :orders, only: [:show, :new, :create, :update] do
    resources :payments, only: [:new, :create]
  end

  resources :menus, only: [:index] do
    resources :line_items, only: [:create]
    resources :menu_items, only: [:create]
  end

  # post '/menus/:menu_id/products/:id/menu_items/new', to: 'menu_items#create', as: 'new_menu_items'

  namespace :admin do
    get '', to: 'products#index', as: '/'
    resources :products, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :menus, only: [:index, :new, :create, :edit, :update, :destroy]
    resources :users, only: [:index, :edit, :destroy]
    resources :orders, only: [:index, :show]
    resources :line_items, only: [:index]
    resources :companies, only: [:index, :new, :create, :edit, :update, :destroy]
  end

end
