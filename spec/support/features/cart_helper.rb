# frozen_string_literal: true

module Features
  def add_to_cart(item)
    within("main ul.catalog li", text: item.title) do
      click_on "Add to Cart"
    end
  end

  def remove_from_cart(item)
    within "#line_item#{item.id}" do
      click_on "Remove"
    end
  end

  def expect_cart_to_be_empty
    expect(page).to have_css(
      "aside#notice",
      text: "Cart is currently empty"
    )

    expect(page).not_to have_css("div#cart")
  end

  # def expect_cart_to_have_item(item)
  #   within "div#cart" do
  #     expect(page).to have_css("td", text: 
  #   end
  # end
end
