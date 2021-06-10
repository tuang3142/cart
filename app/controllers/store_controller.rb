# frozen_string_literal: true

class StoreController < ApplicationController
  include CurrentCart
  include Counter

  before_action :find_or_create_cart, only: :index
  before_action :count_visit, only: :index

  def index
    @products = Product.order(:title)
    @counter = counter
  end
end
