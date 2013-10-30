require 'test_helper'

class ProductTest < ActiveSupport::TestCase
	fixtures(:products) 
	test "product attributes must not by empty" do
		product = Product.new						# product is the model
		assert product.invalid? 					# model has inbuilt methods: invalid?().  because product is empty, it will be invalid --> returns true
		assert product.errors[:title].any?()		# any?() returns true if an error() exists.  Each product field will have an error because it's empty
		assert product.errors[:description].any?()	# all these functions will return true if correct, false in incorrect
		assert product.errors[:price].any?()		
		assert product.errors[:image_url].any?()
	end

	test "product price must be a positive" do
		product = Product.new(title: "my Book Title",
								description: "yyy",
								image_url: "zzz.jpg")
		product.price = -1
		assert product.invalid?
		assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]		# verify the error message is what we expect
																							# assert_equal( expected, actual, [msg])
		product.price = 0 																	# Ensures that expected == actual is true.
		assert product.invalid?
		assert_equal ['must be greater than or equal to 0.01'], product.errors[:price]

		product.price = 1
		assert product.valid?

	end

	def new_product(image_url)
		Product.new(title: "My Book Title",
			description: "yyy",
			price: 1,
			image_url: image_url)
	end
	test "image url" do
		ok = %w{ fred.gif fred.jpg fred.png FRED.JPG FRED.JPG FRED.PNG http://a.b.c/x/y/z/fred.gif}
		bad = %w{ fred.doc fred.gif/more fred.gif.more}
		ok.each do |name|
			assert new_product(name).valid?, "#{name} should be valid"			# second parameter for assert() is a strong which will be written along with the error message
		end
		bad.each do |name|
			assert new_product(name).invalid?, "#{name} shouldn't be valid"
		end
	end

	test "product is not valid without a unique title - i18n"  do
		product = Product.new(title: products(:ruby).title,
			description: "yyy",
			price: 1,
			image_url: "fred.gif")
		assert product.invalid?
		assert_equal [I18n.translate('errors.messages.taken')], product.errors[:title]
	end

end
