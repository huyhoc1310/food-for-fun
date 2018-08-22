module Manager::RestaurantsHelper
  def get_most_ordered_foods restaurant
    most_ordered = {}
    restaurant.foods.each do |food|
      most_ordered[food.name] = 0
      food.order_details.each do |order_details|
        most_ordered[food.name] += order_details.quantity
      end
    end
    most_ordered.sort_by{|_key, value| value}.last(Settings.most_ordered_foods).to_h
  end

  def get_revenue_per_day restaurant
    OrderDetail.get_revenue restaurant
  end
end
