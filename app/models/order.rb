# frozen_string_literal: true

class Order < ApplicationRecord
  # store this somewhere else
  enum payment_method: {
    "Check": 0,
    "Credit card": 1,
    "Purchasr order": 2
  }

  has_many :line_items, dependent: :destroy

  validates :name, :address, :email, presence: true
  validates :payment_method, inclusion: payment_methods.keys

  def add_line_items_from_cart(cart)
    cart.line_items.each do |item|
      item.cart_id = nil
      line_items << item
    end
  end
end
