# frozen_string_literal: true

require "rails_helper"

RSpec.describe "/orders", type: :request do
  describe "GET /new" do
    context "there is item in cart" do
      it "is successful" do
        ruby_book = create(:product)
        post line_items_url,
          params: { product_id: ruby_book.id }, xhr: true

        get new_order_url

        expect(response).to be_successful
      end
    end

    context "no item in cart" do
      it "is not successful" do
        get new_order_url

        expect(flash[:notice]).to eq "Your cart is empty"
      end
    end
  end

  describe "POST /create" do
    context "successful" do
      it "creates an order" do
        # # cart = create(:cart)
        # # ruby_book = create(:line_item, cart: cart)

        # expect {
        #   post orders_url, params: { order: build(:order) }
        # }.to change(Order, :count).by(1)
      end
    end

    context "errors" do
      it "displays error" do
      end
    end
  end
end
