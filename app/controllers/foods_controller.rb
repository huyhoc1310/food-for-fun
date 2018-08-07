class FoodsController < ApplicationController
  before_action :logged_in_user, except: [:index, :show]
  before_action :is_manager?, except: [:index, :show]
  before_action :find_food, only: [:show, :update, :edit]
  before_action :get_categories, only: [:new, :edit]
  before_action :get_images, only: [:edit, :show]
  before_action :load_foods, only: :index

  def index
    @foods = Food.all.page(params[:page]).per Settings.rows
  end

  def show
    @category = Food.category params[:id]
    @images = @food.images
    @category = Food.select("foods.id, categories.name as name_category")
                    .joins(:category)
                    .where("foods.category_id = categories.id AND foods.id = #{params[:id]}")
    @comments = @food.comments.load_parents
  end

  def new
    @food = Food.new
    @categories = Category.all
    @restaurants = Restaurant.includes(:user)
                             .where("restaurants.user_id = #{current_user.id}")
    Settings.image_times.times do
      @image = @food.images.build
    end
  end

  def create
    @food = Food.new food_params
    if @food.save
      flash[:success] = t "food.message.create_success"
      redirect_to @food
    else
      flash[:danger] = t "food.message.create_fail"
      redirect_to root_url
    end
  end

  def edit; end

  def update
    if @food.update_attributes food_params
      flash[:success] = t "food.message.update_success"
      redirect_to @food
    else
      flash[:danger] = t "food.message.update_fail"
      render :edit
    end
  end

  def update_status
    @food = Food.find_by_id params[:food_id]
    if @food.update_attributes status: :disable
      flash[:success] = t "food.message.disable_success"
      redirect_to @food
    else
      flash[:danger] = t "food.message.disable_fail"
      redirect_to root_url
    end
  end

  private

  def food_params
    params.require(:food).permit :name, :description, :price, :rate,
      :restaurant_id, :category_id, :status,
      images_attributes: [:id, :image, :imageable_id, :imageable_type]
  end

  def find_food
    @food = Food.find_by_id params[:id]
    return if @food
    flash[:danger] = t "food.message.not_found"
    redirect_to root_url
  end

  def get_categories
    @categories = Category.all
  end

  def get_images
    @images = @food.images
  end

  def load_foods
    @foods = Food.all
    @foods = Food.by_category params[:category] if params[:category]
  end
end
