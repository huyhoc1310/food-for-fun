class Manager::FoodsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :is_manager?
  before_action :load_restaurant
  before_action :load_categories
  before_action :load_food, only: [:update, :edit]
  before_action :load_images, only: :edit

  def index; end

  def new
    @food = Food.new
    Settings.image_times.times do
      @image = @food.images.build
    end
    store_location
  end

  def create
    @food = @restaurant.foods.build food_params
    if @food.save
      flash[:success] = t "food.message.create_success"
      redirect_to @food
    else
      render :new
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
      :category_id, :status,
      images_attributes: [:id, :image, :imageable_id, :imageable_type]
  end

  def load_restaurant
    @restaurant = Restaurant.find_by id: params[:restaurant_id]
  end

  def load_categories
    @categories = @restaurant.categories.all
  end

  def load_food
    @food = Food.find_by_id params[:id]
    return if @food
    flash[:danger] = t "food.message.not_found"
    redirect_to root_url
  end

  def load_images
    @images = @food.images
  end
end
