class CheckoutController < ApplicationController
  def index
    @items = []
    cart["items"].each do |item|
      product = Product.find(item["id"])
      @items.push({
                    item:    item,
                    product: product
                  })
    end
  end
end
