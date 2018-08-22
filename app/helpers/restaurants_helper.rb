module RestaurantsHelper
  def check_order_restaurant r_id, current_id
    @restaurant = Restaurant.find_by_id r_id
    u_id = @restaurant.user_id
    return @restaurant if u_id === current_id
  end

  def find_restaurant id
    @restaurant = Restaurant.find_by id: id
  end
end
