# frozen_string_literal: true

require "rails_helper"

feature "add line_item to cart" do
  scenario "changes cart line item and display the price" do
    ruby_book, docker_book = create_list(:product, 2)
    visit store_index_path
    expect(page).to have_content ruby_book.title

    add_to_cart(ruby_book)

    within ".cart" do
      expect(page).to have_css("td", text: ruby_book.title)
      expect(page).to have_css("td.price", text: "$#{ruby_book.price}")
    end

    add_to_cart(docker_book)

    within ".cart" do
      expect(page).to have_css("td", text: docker_book.title)
      expect(page).to have_css("td.price", text: "$#{docker_book.price}")
    end

    within ".cart" do
      expect(page).to have_content "Total: $#{Cart.last.total_price}"
    end
  end

  scenario "adding item by clicking the image" do
    ruby_book = create(:product)

    visit store_index_path

    within ".catalog" do
      click_on "Product #{ruby_book.id}"
    end

    within ".cart" do
      expect(page).to have_content(ruby_book.title)
    end
  end
end
