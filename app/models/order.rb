# frozen_string_literal: true

require 'pargo'

class Order < ApplicationRecord
  enum payment_method: {
    "Check": 0,
    "Credit card": 1,
    "Purchase order": 2
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

  def charge!(payment_method_params)
    payment_details = {}
    pay_type = nil

    case payment_method
    when "Check"
      pay_type = :check
      payment_details[:routing] = payment_method_params[:routing_number]
      payment_details[:account] = payment_method_params[:account_number]
    when "Credit card"
      pay_type = :credit_card
      month,year = payment_method_params[:expiration_date].split(//)
      payment_details[:cc_num] = payment_method_params[:credit_card_number]
      payment_details[:expiration_month] = month
      payment_details[:expiration_year] = year
    when "Purchase order"
      pay_type = :po
      payment_details[:po_num] = payment_method_params[:po_number]
    end

    payment_result = Pargo.make_payment(
      order_id: id,
      payment_method: pay_type,
      payment_details: payment_details
    )

    if payment_result.succeeded?
      OrderMailer.received(self).deliver_later
    else
      raise payment_result.error
    end
  end
end
