class RestaurantsController < ApplicationController
  before_action :load_restaurant, only: :show
  before_action :load_restaurants, only: :index

  def index; end

  def show
    @suggests = @restaurant.suggests.all
  end

  def restaurant_foods
    @restaurant = Restaurant.find_by_id params[:restaurant_id]
    if current_order.nil?
      @order_detail = OrderDetail.new
    else
      @order_detail = current_order.order_details.new
    end
  end

  private

  def load_restaurant
    @restaurant = Restaurant.find_by id: params[:id]
    return if @restaurant
    flash[:danger] = t "flashs.not_found_restaurant"
    redirect_to root_path
  end

  def load_restaurants
    @restaurants = Restaurant.all
    @restaurants = Restaurant.by_city params[:city] if params[:city]
  end
end
