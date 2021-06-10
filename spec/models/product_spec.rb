# frozen_string_literal: true

require "rails_helper"

RSpec.describe Product, type: :model do
  describe "#title" do
    it "has at least 10 characters" do
      product = create(:product)
      expect(product).to be_valid
    end
  end

  describe "#destroy" do
    it "cant be destroy if is referenced by a line_item" do
      product = create(:product)
      cart = create(:cart)
      line_item = create(:line_item, cart: cart, product: product)

      expect { product.destroy! }.to raise_error(ActiveRecord::RecordNotDestroyed)
      expect(product.errors.messages).to eq({ product: ["is referenced by a LineItem"] })
    end
  end

  describe "#add_product" do
    context "a line item of the product is in the cart" do
      it "increases quantity of the line item" do
        cart = create(:cart)
        ruby_book = create(:product)
        ruby_book_item = cart.line_items.create(product: ruby_book)

        # expect { cart.reload.add_product(ruby_book) }.to change { ruby_book_item.quantity }.by 1
        expect(ruby_book_item.quantity).to eq 1
        cart.reload.add_product(ruby_book)
        expect(ruby_book_item.reload.quantity).to eq 2
      end
    end

    context "a line item of the product is not yet created" do
      it "builds a new line item" do
      end
    end
  end
end
