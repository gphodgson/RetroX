class ProductsController < ApplicationController
  def index
    @catagories = Catagory.all
    @products = Product.all

    if params[:console_id].present?
      catagory = Catagory.find(params[:console_id])
      @products = catagory.products
    end

    @page = 1

    @page = params[:page].to_i if params[:page].present?

    @products = @products.page(@page)

    if params[:filter_id].present?
      filter_id = params[:filter_id]
      if filter_id == "1"
        @products = @products.where(Product.new_products_query)
      elsif filter_id == "2"
        @products = @products.where(Product.recently_updated_products_query)
      end
    end

    if params[:query].present?
      @products = @products.where("name LIKE :query", query: "%#{params[:query]}%")
    end
  end

  def show
    @product = Product.find(params[:id])
  end
end
