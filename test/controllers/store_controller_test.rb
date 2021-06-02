require "test_helper"

class StoreControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    product_count = 3
    create_list(:product, product_count)

    get store_index_url

    assert_response :success
    assert_select 'nav.side_nav a', minimum: 4
    assert_select 'main ul.catalog li', product_count
    assert_select 'h2', Product.first.title
    assert_select '.price', /\$[,\d]+\.\d\d/
  end
end
