# frozen_string_literal: true

Rails.application.routes.draw do
  root "store#index", as: "store_index"

  resources :line_items
  resources :carts
  resources :products
  resources :orders
end
