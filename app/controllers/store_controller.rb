# frozen_string_literal: true

class StoreController < ApplicationController
  include CurrentCart

  before_action :find_or_create_cart, only: :index

  def index
    @products = Product.order(:title)
  end
end
