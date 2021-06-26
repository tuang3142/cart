# frozen_string_literal: true

require "rails_helper"

describe "visit products page" do
  it "shows products with detail" do
    product_count = 3
    book = create_list(:product, product_count).first

    visit store_index_url

    expect(page).to have_css("main ul.catalog li", count: product_count.to_i)
    expect(page).to have_content book.title
    expect(page).to have_content book.description
    expect(page).to have_content "$#{book.price}"
  end
end
