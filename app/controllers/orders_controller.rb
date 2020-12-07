class OrdersController < ApplicationController
  SAVED_ADDRESS_TYPE = "saved_address".freeze
  NEW_ADDRESS_TYPE = "new_address".freeze

  def new
    @order = Order.new
  end

  def create
    type_of_address = params[:type]

    if type_of_address == SAVED_ADDRESS_TYPE
      address = Address.find(params[:address_id])
    elsif type_of_address == NEW_ADDRESS_TYPE
      address = Address.create(line1:      params[:line1],
                               line2:      params[:line2],
                               city:       params[:city],
                               state:      params[:state],
                               country:    params[:country],
                               phone:      params[:phone],
                               postalCode: params[:postalCode])

      current_user.address = address if params[:save]
    end

    new_order = Order.create(total_price: 0,
                             state:       Order::NEW,
                             address:     address,
                             user:        logged_in? ? current_user : User.find_by(name: "guest"))

    logger.debug(new_order.errors.messages) unless new_order.valid?

    total = 0

    cart["items"].each do |item|
      product = Product.find(item["id"])
      logger.debug(product.name)
      item = new_order.ordered_items.create(amount:  item["amount"],
                                            price:   product.price,
                                            product: product)
      total += item["amount"] * product.price
      logger.debug(item.errors.messages) unless item.valid?
    end
    new_order.total_price = total
    new_order.save

    session["cart"]["items"] = []
    session["cart"]["amount"] = 0

    redirect_to order_path(new_order.id)
  end

  def show
    @order = Order.find(params[:id])

    if current_user.nil? && @order.user.id != 5
      redirect_to root_path
      return
    end

    redirect_to root_path if @order.user.id != current_user.id
  end

  def destroy
    order = Order.find(params[:id])
    order.state = Order::CANCELLED
    order.save
    redirect_to user_path(current_user.id)
  end
end
