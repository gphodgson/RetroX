class ApplicationController < ActionController::Base
  helper_method :current_user
  helper_method :logged_in?

  before_action :init_session
  helper_method :cart

  private

  def cart
    session[:cart]
  end

  def init_session
    session[:test] = "test"
    session[:cart] ||= {
      "amount": 0,
      "items":  []
    }
  end

  def current_user
    User.find_by(id: session[:user_id])
  end

  def logged_in?
    !current_user.nil?
  end
end
