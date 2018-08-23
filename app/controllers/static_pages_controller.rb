class StaticPagesController < ApplicationController
  def home
    @categories = Category.all.map{|category| [category.name, category.id]}
    @restaurants = if logged_in? && is_manager?
                     Restaurant.where user_id: current_user.id
                   elsif logged_in? && is_user?
                     Restaurant.all
    end
  end

  def help; end

  def about; end

  def contact; end
end
