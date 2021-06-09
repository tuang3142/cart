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
end
