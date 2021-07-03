# frozen_string_literal: true

require "rails_helper"

feature "add line_item to cart" do
  context "increase" do
    scenario "successfully" do
      ruby_book = create(:product)
      visit store_index_path
      add_to_cart(ruby_book)

      line_item = LineItem.last

      within ".cart" do
        expect { click_on "+" }
          .to change { line_item.reload.quantity }
          .from(1).to 2
      end
    end
  end

  context "decrease" do
    scenario "successfully" do
      ruby_book = create(:product)
      visit store_index_path
      add_to_cart(ruby_book, quantity: 2)

      line_item = LineItem.last

      within ".cart" do
        expect { click_on "-" }
          .to change { line_item.reload.quantity }
          .from(2).to 1
      end
    end

    scenario "remove cart if quantity equals zero" do
      ruby_book = create(:product)
      visit store_index_path
      add_to_cart(ruby_book)

      within ".cart" do
        expect { click_on "-" }
          .to change(LineItem, :count)
          .from(1).to 0
      end

      expect(page).not_to have_content("Your Cart")
    end
  end
end
