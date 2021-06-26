def add_to_cart(item)
  within("main ul.catalog li", text: item.title) do
    click_on "Add to Cart"
  end
end
