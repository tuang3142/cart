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
    product = build(:product)

    product.price = -1
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal ["must be greater than or equal to 0.01"], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  test "image url" do
    good_urls = %w[fred.gif fred.jpg fred.png fred.jpeg
      FRED.JPG FRED.Jpg http://a.b.c/x/y/z/fred.gif]
    bad_urls = %w[fred.doc fred.gif/more fred.gif.more]

    good_urls.each do |url|
      assert build(:product, image_url: url).valid?,
        "#{url} should be valid"
    end

    bad_urls.each do |url|
      assert build(:product, image_url: url).invalid?,
        "#{url} should be invalid"
    end
  end

  test "product title must be at least 10 characters" do
    product = build(:product)

    product.title = "012345678"
    assert product.invalid?
    assert_equal ["is too short (minimum is 10 characters)"], product.errors[:title]

    product.title = "0123456789"
    assert product.valid?
  end
end
