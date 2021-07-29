Rails.application.routes.draw do
  get 'issues/index'
  get 'issues/show'
  resources :order_items
  resources :orders
  resources :employees
  resources :products
  resources :categories
  root 'home#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
