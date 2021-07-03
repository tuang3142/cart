# frozen_string_literal: true

class Order < ApplicationRecord
  enum payment_method: {
    "Cash On Delivery": 0,
    "Credit Card": 1,
    "Bank Transfer": 2
  }
end
