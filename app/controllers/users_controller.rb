class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    if session[:user_id] != @user.id
      redirect_to root_url
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.create(params.require(:user).permit(:name, :password, :email))
    session[:user_id] = @user.id
    redirect_to root_url
  end

  def login; end
end
