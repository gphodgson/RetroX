class HomeController < ApplicationController
  def index
    @products = Product.new_products.limit(5).order("created_at")
  end
end
