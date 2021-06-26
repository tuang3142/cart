# frozen_string_literal: true

require "rails_helper"

feature "User views session counter in store index" do
  scenario "user visits store index" do
    visit store_index_path

    expect(page).to have_content("Visitted 1 time")

    visit carts_path
    visit store_index_path

    expect(page).to have_content("Visitted 2 times")
  end

  scenario "user adds item to cart" do
    ruby_book = create(:product)
    visit store_index_path
    expect(page).to have_content("Visitted 1 time")

    visit carts_path
    visit store_index_path
    expect(page).to have_content("Visitted 2 times")

    add_to_cart(ruby_book)

    expect(page).to have_content("Visitted 1 time")
  end
end
