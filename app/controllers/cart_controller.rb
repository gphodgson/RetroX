class CartController < ApplicationController
  def create
    product_id = params[:id]
    product = Product.find(product_id)

    unless edit_cart_item(product.name)
      add_to_card(product)
    end

    redirect_to product_path(product_id)
  end

  def destroy; end

  def add_to_card(product)
    session["cart"]["items"].push({
      "name":   product.name,
      "price":  product.price,
      "amount": 1
    })
  session["cart"]["amount"] += 1
  end

  def edit_cart_item(product_name)
    session["cart"]["items"].each do |item|
      if item["name"] == product_name
        item["amount"] += 1
        return true
      end
    end

    false
  end
end
