require "test_helper"

class ProductTest < ActiveSupport::TestCase
  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:image_url].any?
    assert product.errors[:price].any?
  end

  test "product price must be possitive" do
    product = Product.new(
      title: "at least 10 chars title",
      description: "desc",
      image_url: "url.jpg"
    )

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(image_url="image.png")
    Product.new(
      title: "My Book Title",
      description: "yyy",
      price: 1,
      image_url: image_url
    )
  end

  test "image url" do
    good_urls = %w[fred.gif fred.jpg fred.png FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif]
    bad_urls = %w[fred.doc fred.gif/more fred.gif.more]

    good_urls.each do |url|
      assert new_product(url).valid?, "#{url} should be valid"
    end

    bad_urls.each do |url|
      assert new_product(url).invalid?, "#{url} should be invalid"
    end
  end

  test "product title must be unique" do
    product = new_product
    product.title = products(:ruby).title

    assert product.invalid?
    assert_equal ["has already been taken"], product.errors[:title]
  end

  test "product title must be at least 10 characters" do
    product = new_product

    product.title = "012345678"
    assert product.invalid?
    assert_equal ["is too short (minimum is 10 characters)"], product.errors[:title]

    product.title = "0123456789"
    assert product.valid?
  end
end
