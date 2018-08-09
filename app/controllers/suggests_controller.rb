class SuggestsController < ApplicationController
  before_action :logged_in_user, only: %i(create destroy)
  before_action :load_restaurant, only: :create
  before_action :correct_user, only: :destroy

  def new
    @suggest = Suggest.new
  end

  def show; end

  def create
    @suggest = @restaurant.suggests.build suggest_params
    @suggest.user = current_user
    if @suggest.save
      flash[:info] = t "flashs.create_suggest_success"
      redirect_to @restaurant
    else
      render :new
    end
  end

  def destroy
    if @suggest.destroy
      flash[:success] = t "flashs.suggest_deleted"
    else
      flash[:danger] = t "flashs.fail_delete_suggest"
    end
    redirect_to request.referrer || @restaurant
  end

  private

  def suggest_params
    params.require(:suggest).permit :title, :content
  end

  def load_restaurant
    @restaurant = Restaurant.find_by id: params[:restaurant_id]
    return if @restaurant
    flash[:danger] = t "flashs.not_found_restaurant"
    redirect_to root_path
  end

  def correct_user
    @suggest = current_user.suggests.find_by id: params[:id]
    redirect_to root_url if @suggest.nil?
  end
end
