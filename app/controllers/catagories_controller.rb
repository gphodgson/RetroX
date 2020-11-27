class CatagoriesController < ApplicationController
  def show
    @catagory = Catagory.find(params[:id])
  end
end
