# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  describe "#add_product" do
    it "increases quantity of the line item" do
      cart = create(:cart)
      ruby_book = create(:product)
      ruby_book_item = cart.line_items.create(product: ruby_book)
      expect(ruby_book_item.quantity).to eq 1

      cart.add_product(ruby_book)

      expect(ruby_book_item.reload.quantity).to eq 2
    end
  end
end
