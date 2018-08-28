class FoodsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  before_action :is_manager?, except: [:index, :show]
  before_action :find_food, only: [:show, :update, :edit]
  before_action :get_images, only: [:edit, :show]
  before_action :load_foods, only: :index
  before_action :load_restaurant, only: :show

  def index; end

  def show
    @category = Food.category params[:id]
    @images = @food.images
    @category = Food.select("foods.id, categories.name as name_category")
                    .joins(:category)
                    .where("foods.category_id = categories.id AND foods.id = #{params[:id]}")
    @comments = @food.comments.load_parents
  end

  private

  def find_food
    @food = Food.find_by_id params[:id]
    return if @food
    flash[:danger] = t "food.message.not_found"
    redirect_to root_url
  end

  def get_images
    @images = @food.images
  end

  def load_foods
    @foods = Food.all.page(params[:page]).per Settings.rows
    @foods = Food.by_category params[:category] if params[:category]
  end

  def load_restaurant
    @restaurant = Restaurant.find_by id: params[:restaurant_id]
  end
end
