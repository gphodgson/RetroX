class CartController < ApplicationController
  def create
    product_id = params[:id]
    product = Product.find(product_id)

    add_to_cart(product) unless edit_cart_item(product.name)

    redirect_to product_path(product_id)
  end

  def destroy
    index_to_remove = nil
    cart["items"].each_with_index do |item, i|
      index_to_remove = i if item["id"].to_s == params[:id].to_s
    end

    if index_to_remove.present?
      cart["items"].delete_at(index_to_remove)
      cart["amount"] -= 1
    end

    redirect_to checkout_index_path
  end

  def update
    product_id = params[:id]
    add = params[:add]

    cart["items"].each do |item|
      next unless item["id"].to_s == product_id.to_s

      if add == "true"
        item["amount"] += 1
      else
        if item["amount"] <= 1
          destroy
        else
          item["amount"] -= 1
        end
      end

      break
    end

    redirect_to checkout_index_path
  end

  private

  def add_to_cart(product)
    session["cart"]["items"].push({
                                    "name":   product.name,
                                    "price":  product.price,
                                    "id":     product.id,
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
