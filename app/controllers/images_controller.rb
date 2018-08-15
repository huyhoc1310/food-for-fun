class ImagesController < ApplicationController
  before_action :load_data

  def show; end

  def edit
    respond_to do |format|
      format.html
      format.js
    end
  end

  def update
    if @image.update_attributes image_params
      flash[:success] = t "food.message.update_success"
      redirect_to @food
    else
      flash[:danger] = t "food.message.update_fail"
      render :edit
    end
  end

  private

  def image_params
    params.require(:image).permit :image, :imageable_id, :imageable_type
  end

  def load_data
    @food = Food.find_by_id params[:food_id]
    if @food.nil?
      flash[:danger] = t "food.message.not_found"
    else
      @image = @food.images.find_by_id params[:id]
      return if @image.nil?
    end
  end
end
