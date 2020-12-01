class HomeController < ApplicationController
  def index
    @new_products = Product.new_products.limit(5).order("created_at")
    @expensive_games = Product.all.order("price DESC").limit(4)
    @rare_games = Product.all.order("stock ASC").limit(4)
  end
end
