class SearchController < ApplicationController
  def index
    if params[:search].blank?
      flash[:danger] = t("food.error.search")
      redirect_to root_path
    else
      @foods = Food.search_foods params[:search]
      @restaurants = Restaurant.search_restaurants params[:search]
      if @foods.empty? && @restaurants.empty?
        flash[:danger] = t "flashs.not_found"
        redirect_to root_path
      end
    end
  end
end
