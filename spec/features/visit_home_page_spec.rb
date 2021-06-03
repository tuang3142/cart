require "rails_helper"

describe "visit products page", type: :feature do
   it "shows products with detail" do
    product = create(:product)

    visit store_index_url

    expect(page).to have_content product.title
    expect(page).to have_content product.description
    expect(page).to have_content product.price
  end
end
