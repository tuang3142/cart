# frozen_string_literal: true

require "rails_helper"

describe "add line_item to cart", type: :feature, chrome_headless: true do
  it "changes cart line item and display the price" do
    ruby_book, docker_book = create_list(:product, 2)
    visit store_index_path
    expect(page).to have_content ruby_book.title

    within("main ul.catalog li", text: ruby_book.title) do
      click_on "Add to Cart"
    end

    within("article") do
      expect(page).to have_css("h2", text: "Your Cart")
      expect(page).to have_css("td", text: ruby_book.title)
      expect(page).to have_css("td.price", text: "$#{ruby_book.price}")
    end

    within("main ul.catalog li", text: docker_book.title) do
      click_on "Add to Cart"
    end

    within("article") do
      expect(page).to have_css("h2", text: "Your Cart")
      expect(page).to have_css("td", text: docker_book.title)
      expect(page).to have_css("td.price", text: "$#{docker_book.price}")
    end

    within("article") do
      expect(page).to have_css("h2", text: "Your Cart")
      expect(page).to have_css("th", text: "Total")
      expect(page).to have_css("td.price", text: "$#{Cart.last.total_price}")
    end
  end
end
