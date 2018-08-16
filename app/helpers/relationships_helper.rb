module RelationshipsHelper
  def follow_restaurant
    current_user.active_relationships.build
  end

  def unfollow_restaurant
    current_user.active_relationships.find_by restaurant_id: @restaurant.id
  end
end
