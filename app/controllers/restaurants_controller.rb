class RestaurantsController < ApplicationController
  before_action :load_restaurant

  def show
    @suggests = @restaurant.suggests.all
  end

  private

  def load_restaurant
    @restaurant = Restaurant.find_by id: params[:id]
    return if @restaurant
    flash[:danger] = t "flashs.not_found_restaurant"
    redirect_to root_path
  end
end
