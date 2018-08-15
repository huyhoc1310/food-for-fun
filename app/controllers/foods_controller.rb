class FoodsController < ApplicationController
  before_action :find_food, only: [:show, :update, :edit]
  before_action :get_categories, only: [:new, :edit]
  before_action :get_images, only: [:edit, :show]

  def index; end

  def show
    @category = Food.category params[:id]
  end

  def new
    @food = Food.new
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

  private

  def food_params
    params.require(:food).permit :name, :description, :price, :rate,
      :restaurant_id, :category_id,
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
end
