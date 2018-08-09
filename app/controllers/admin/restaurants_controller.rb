class Admin::RestaurantsController < ApplicationController
  before_action :is_admin?
  def index
    @restaurants = Restaurant.sort_restaurants.page(params[:page])
                             .per Settings.rows
  end
end
