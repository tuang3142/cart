# frozen_string_literal: true

require "rails_helper"

describe "add line_item to cart", type: :feature do
  it "redirects" do
    create_list(:product, 3)
    book = Product.first
    visit store_index_url

    expect(page).to have_content book.title
    within("main ul.catalog li", text: book.title) do
      expect { click_on "Add to Cart" }
        .to change(LineItem, :count).by(1)
        .and change(Cart, :count).by(1)
      expect(page).to have_current_path cart_path(Cart.last)
    end
  end
end
