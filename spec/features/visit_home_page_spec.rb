require "rails_helper"

describe "visit products page", type: :feature do
   it "shows all products" do
    visit "/products"
    expect(page).to have_content "Products"
    expect(page).to have_content "New Product"
  end
end
