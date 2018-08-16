class RelationshipsController < ApplicationController
  before_action :logged_in_user

  def create
    @restaurant = Restaurant.find_by(id: params[:restaurant_id])
    current_user.follow @restaurant
    respond_to do |format|
      format.html{redirect_to @restaurant}
      format.js
    end
  end

  def destroy
    @restaurant = Relationship.find_by(id: params[:id]).followed
    current_user.unfollow @restaurant
    respond_to do |format|
      format.html{redirect_to @restaurant}
      format.js
    end
  end
end
