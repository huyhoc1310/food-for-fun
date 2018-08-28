class Manager::MenusController < ApplicationController
  before_action :find_restaurant, only: [:show]
  before_action :find_food, only: [:edit]

  def show
    @foods = Food.find_food_enable(params[:id]).page(params[:page]).per Settings.rows
  end

  def edit; end

  def delete_food
    @food = Food.find_by_id params[:menu_id]
    restaurant_id = @food.restaurant_id
    if @food.update_attributes status: :disable
      flash[:success] = t "food.message.disable_success"
      redirect_to manager_menu_path(restaurant_id)
    else
      flash[:danger] = t "food.message.disable_fail"
      redirect_to manager_menu_path(restaurant_id)
    end
  end

  private

  def find_restaurant
    @restaurant = Restaurant.find_by_id params[:id]
    return if @restaurant.nil?
  end

  def find_food
    @food = Food.find_by_id params[:id]
    @categories = @food.restaurant.categories
    restaurant_id = @food.restaurant_id
    return if @food.nil?
  end
end
