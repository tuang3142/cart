# frozen_string_literal: true

module Features
  def add_to_cart(item, quantity: 1)
    within("main ul.catalog li", text: item.title) do
      quantity.times { click_on "Add to Cart" }
    end
  end

  def remove_from_cart(item)
    within "#line_item#{item.id}" do
      click_on "Remove"
    end
  end
end
