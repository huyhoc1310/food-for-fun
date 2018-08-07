module FoodsHelper
  def find_food_restaurant id
    @food = Food.find_food_of_restaurant id
  end

  def find_food id
    @food = Food.find_by_id id
  end
end
