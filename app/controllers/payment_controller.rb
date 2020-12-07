class PaymentController < ApplicationController
  def create
    order = Order.find(params[:id])

    if order.nil?
      redirect_to root_path
      return
    end

    logger.debug("ENV: #{Rails.configuration.stripe[:P_KEY]}")

    items = []

    order.ordered_items.each do |item|
      items.push({
                   name:        item.product.name,
                   description: "Video Game",
                   amount:      (item.price * 100).to_i,
                   currency:    "cad",
                   quantity:    item.amount
                 })
    end

    @session = Stripe::Checkout::Session.create(
      payment_method_types: ["card"],
      success_url:          payment_success_url + "?id=#{order.id}",
      cancel_url:           payment_cancel_url,
      line_items:           items
    )

    respond_to do |f|
      f.js
    end
  end

  def success
    order = Order.find(params[:id])

    order.ordered_items.each do |item|
      item.product.stock -= item.amount
      item.product.save
    end

    order.state = Order::PROCESSING
    order.save

    redirect_to order_path(order.id)
  end

  def cancel; end
end
