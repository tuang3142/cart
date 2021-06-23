Rails.application.routes.draw do
  resources :orders
  root "store#index", as: "store_index"

  resources :line_items
  resources :carts
  resources :products
end
