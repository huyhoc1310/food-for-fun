class Manager::RestaurantsController < ApplicationController
  before_action :is_manager?
  before_action :find_restaurant, only: %i(show edit update destroy)

  def index
    @restaurants = Restaurant.includes(:user)
                             .where("restaurants.user_id = #{current_user.id}")
  end

  def new
    @restaurant = Restaurant.new
  end

  def create
    @restaurant = current_user.restaurants.build restaurant_params
    @restaurant.user_id = current_user.id
    if @restaurant.save
      flash[:success] = t "manager.create_success"
      redirect_to manager_restaurants_path
    else
      flash[:error] = t "manager.restaurants.create_error"
      render :new
    end
  end

  def edit; end

  def update
    if @restaurant.update_attributes restaurant_params
      flash[:success] = t "manager.restaurants.update_success"
      redirect_to manager_restaurants_path
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
