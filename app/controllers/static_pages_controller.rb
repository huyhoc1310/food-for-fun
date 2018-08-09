class StaticPagesController < ApplicationController
  def home
    @categories = Category.all.map{|category| [category.name, category.id]}
  end

  def help; end

  def about; end

  def contact; end
end
