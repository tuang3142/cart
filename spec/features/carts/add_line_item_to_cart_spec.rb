# frozen_string_literal: true

require "rails_helper"

feature "add line_item to cart" do
  scenario "changes cart line item and display the price" do
    ruby_book, docker_book = create_list(:product, 2)
    visit store_index_path
    expect(page).to have_content ruby_book.title

    add_to_cart(ruby_book)

    within("article") do
      expect(page).to have_css("h2", text: "Your Cart")
      expect(page).to have_css("td", text: ruby_book.title)
      expect(page).to have_css("td.price", text: "$#{ruby_book.price}")
    end

    add_to_cart(docker_book)

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
