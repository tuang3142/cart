# frozen_string_literal: true

class Order < ApplicationRecord
  enum payment_method: {
    "Cash On Delivery": 0,
    "Credit Card": 1,
    "Bank Transfer": 2
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
