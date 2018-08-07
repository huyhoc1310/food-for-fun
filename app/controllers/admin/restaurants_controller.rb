class Admin::RestaurantsController < ApplicationController
  before_action :find_restaurant, only: %i(show edit update destroy)

  def index
    @restaurants = Restaurant.sort_restaurant.page(params[:page])
                             .per Settings.rows
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = Restaurant.new restaurant_params
    if @restaurant.save
      flash[:success] = t "admin.restaurants.create_success"
      redirect_to admin_restaurants_path
    else
      flash[:error] = t "admin.restaurants.create_error"
      render :new
    end
  end

  def edit; end

  def update
    if @restaurant.update_attributes restaurant_params
      flash[:success] = t "admin.restaurants.update_success"
      redirect_to admin_restaurants_path
    else
      render :edit
    end
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find_by id: params[:id]
    return if @restaurant
    flash[:danger] = t "admin.restaurants.not_found"
  end

  def restaurant_params
    params.require(:restaurant).permit :name, :description, :address,
      :phone_number, :user_id
  end
end
