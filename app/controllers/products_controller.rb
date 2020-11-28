class ProductsController < ApplicationController
  def index
    @catagories = Catagory.all
    @products = Product.get_filtered_products(params)
    @page = params[:page].present? ? params[:page].to_i : 1
  end

  def show
    @product = Product.find(params[:id])
  end
end
