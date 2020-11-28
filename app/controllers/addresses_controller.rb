class AddressesController < ApplicationController
  def new
    @address = Address.new
  end

  def create
    @address = current_user.addresses.create(params.require(:address).permit(:line1,
                                                                             :line2,
                                                                             :city,
                                                                             :state,
                                                                             :country,
                                                                             :phone,
                                                                             :postalCode))
    redirect_to user_path(current_user.id)
  end
end
