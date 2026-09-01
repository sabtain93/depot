require "test_helper"

class ProductTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  fixtures :products

  test "product attributes must not be empty" do
    product = Product.new
    assert product.invalid?
    assert product.errors[:title].any?
    assert product.errors[:description].any?
    assert product.errors[:price].any?
    assert product.errors[:image].any?
  end

  test "product title must be atleast 10 characters in length" do
    product = Product.new( title: 'Power', description: 'yyyy')
    product.image.attach(io: File.open('test/fixtures/files/lorem.jpg'), filename: 'lorem.jpg', content_type: "image/jpeg")
    product.price = 2

    assert product.invalid?, "title must have 10 or more characters"
    assert_equal [ "is too short (minimum is 10 characters)" ], product.errors[:title]

    product.title = 'The 48 Laws of Power'
    assert product.valid?
  end

  test "product price must be positive" do
    product = Product.new(title: 'My great book', description: 'yyys')
    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"), filename: 'lorem.jpg', content_type: "image/jpeg")

    product.price = -1
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]

    product.price = 0
    assert product.invalid?
    assert_equal [ "must be greater than or equal to 0.01" ], product.errors[:price]

    product.price = 1
    assert product.valid?
  end

  def new_product(filename, content_type)
    Product.new(title: 'My Book title',
      description: 'yyy',
      price: 1,
    ).tap do |prod|
      prod.image.attach(io: File.open("db/images/#{filename}"), filename:, content_type:)
    end
  end

  test 'image url' do
    product = new_product('TWBC.jpg', 'image/jpg')
    assert product.valid?, "image/jpeg must be valid"

    product = new_product('logo.svg', 'image/svg+xml')
    assert_not product.valid?, "image/svg+xml must be invalid"
  end

  test 'product is not valid without a unique title' do
    product = Product.new(title: products(:pragprog).title,
                          description: 'this is the description',
                          price: 1)

    product.image.attach(io: File.open("test/fixtures/files/lorem.jpg"),
                        filename: 'lorem.jpg', content_type: "image/jpeg")

    assert product.invalid?
    assert_equal [ "has already been taken" ], product.errors[:title]
    
    
  end
end
