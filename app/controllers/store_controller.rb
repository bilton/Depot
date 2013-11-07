class StoreController < ApplicationController
  def index
  	@products = Product.order(:title)			# instance of Product (model) arranged in order of title
  end
end
