class FoodsController < ApplicationController
  before_action :find_food, only: [:show, :update, :edit]

  def index; end

  def show
    @images = @food.images
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

  def edit
    @images = @food.images
  end

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
      images_attributes: [:id, :image, :imageable_id, :imageable_type]
  end

  def find_food
    @food = Food.find_by_id params[:id]
    return if @food
    flash[:danger] = t "food.message.not_found"
    redirect_to root_url
  end
end
