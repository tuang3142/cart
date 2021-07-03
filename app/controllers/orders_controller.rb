# frozen_string_literal: true

class OrdersController < ApplicationController
  include CurrentCart
  before_action :find_or_create_cart, only: %i[new]
  before_action :ensure_cart_isnt_empty, only: :new

  def new; end

  private

  def ensure_cart_isnt_empty
    return unless @current_cart.line_items.empty?

    redirect_to store_index_url, notice: "Your cart is empty"
  end
end
