# frozen_string_literal: true

require "rails_helper"

describe "add line_item to cart", type: :feature do
  it "redirects" do
    ruby_book, docker_book = create_list(:product, 2)
    visit store_index_url
    expect(page).to have_content ruby_book.title

    within("main ul.catalog li", text: ruby_book.title) do
      expect { click_on "Add to Cart" }
        .to change(LineItem, :count).by(1)
        .and change(Cart, :count).by(1)
    end

    expect(page).to have_current_path cart_path(Cart.last)
    expect(page).to have_css("aside#notice", text: "Line item was successfully created.")
    expect(page).to have_css("h2", text: "Your Pragmatic Cart")
    expect(page).to have_css("li", text: ruby_book.title)

    # should be go back wtf
    visit store_index_url

    within("main ul.catalog li", text: docker_book.title) do
      expect { click_on "Add to Cart" }
        .to change(LineItem, :count).by(1)
        .and change(Cart, :count).by(0)
    end

    expect(page).to have_current_path cart_path(Cart.last)
    expect(page).to have_css("aside#notice", text: "Line item was successfully created.")
    expect(page).to have_css("h2", text: "Your Pragmatic Cart")
    expect(page).to have_css("li", text: ruby_book.title)
    expect(page).to have_css("li", text: docker_book.title)
  end
end
