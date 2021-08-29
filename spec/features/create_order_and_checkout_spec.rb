# frozen_string_literal: true

require "rails_helper"

feature "user checks out" do
  include ActiveJob::TestHelper

  after do
    clear_enqueued_jobs
  end

  context "cart has items" do
    scenario "sucessfully", :browser_headless do

      ruby_book = create(:product)

      visit store_index_path
      add_to_cart(ruby_book)
      click_on "Check out"

      expect(page).to have_content("Please Enter Your Details")
      expect(page).not_to have_css("input.checkout")

      fill_in_checkout_form

      expect { click_on "Place Order" }
        .to change(Order, :count).by 1
    end
  end
end
