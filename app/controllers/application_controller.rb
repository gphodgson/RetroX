class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  before_action :init_session
  helper_method :cart
  helper_method :cart_subtotal
  helper_method :init_session

  private

  def cart
    session[:cart]
  end

  def init_session
    session[:cart] ||= {
      "amount" => 0,
      "items"  => []
    }
    logger.debug("TEST: #{session[:cart]}")
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end

  def cart_subtotal
    subtotal = 0
    cart["items"].each do |item|
      subtotal += item["price"].to_i * item["amount"].to_i
    end

    subtotal
  end
end
