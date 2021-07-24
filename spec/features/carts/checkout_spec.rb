# frozen_string_literal: true

require "rails_helper"

feature "check out" do
  scenario "successful" do
    ruby_book = create(:product)

    visit store_index_url

    add_to_cart ruby_book

    expect(page).to have_css(".button_to .checkout")
  end
end
