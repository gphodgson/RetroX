class SessionsController < ApplicationController
  def new; end

  def create
    @user = User.find_by(name: params[:name])
    session[:user_id] = @user.id if @user&.authenticate(params[:password])

    redirect_to root_url
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url
  end
end
