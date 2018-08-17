class StaticPagesController < ApplicationController
  def home
    @categories = Category.all.map{|category| [category.name, category.id]}
    if logged_in? && is_manager?
      @restaurants = Restaurant.where user_id: current_user.id
    else
      @restaurants = Restaurant.all
    end
  end

  def help; end

  def about; end

  def contact; end
end
