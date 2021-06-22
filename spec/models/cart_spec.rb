# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  describe "#add_product" do
    context "line_item is not in cart" do
      it "returns a new line_item" do
        cart = create(:cart)
        ruby_book = create(:product)
        book_item = cart.add_product(ruby_book)

        expect(book_item).to be_a(LineItem)
        expect(book_item).to be_new_record
      end
    end
  end
end
