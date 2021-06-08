# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/product", type: :request do
  describe "DELETE /destroy" do
    context "product is added to cart as line_item" do
      it "can't destroy the requested product" do
        product = create(:product)
        cart = create(:cart)
        line_item = create(:line_item, cart: cart, product: product)

        expect { delete product_url(product) }
          .to raise_error(ActiveRecord::InvalidForeignKey)
        expect(Product.count).to eq 1
      end
    end
  end
end
