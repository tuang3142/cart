# frozen_string_literal: true

require "rails_helper"

feature "User removes a line item from cart" do
  scenario "successfully" do
    ruby_book, docker_book = create_list(:product, 2)

    visit store_index_path

    add_to_cart(ruby_book)
    add_to_cart(docker_book)

    remove_from_cart(ruby_book)
    remove_from_cart(docker_book)

    expect(page).not_to have_content("Your Cart")
  end
end
