class CategoriesController < ApplicationController
  before_action :is_manager?
  before_action :load_restaurant
  before_action :load_categories

  def new
    @category = Category.new
    @image = @category.images.build
  end

  def create
    @category = @restaurant.categories.build category_params
    if @category.save
      flash[:success] = t "flashs.create_category_success"
      redirect_to @restaurant
    else
      render :new
    end
  end

  private

  def category_params
    params.require(:category).permit :parent_id, :name,
      images_attributes: [:id, :image, :imageable_id, :imageable_type]
  end

  def load_restaurant
    @restaurant = Restaurant.find_by id: params[:restaurant_id]
    return if @restaurant
    flash[:danger] = t "flashs.not_found_restaurant"
    redirect_to root_path
  end

  def load_categories
    @categories = @restaurant.categories.all
  end
end
