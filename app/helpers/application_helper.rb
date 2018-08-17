module ApplicationHelper
  def full_title page_title = ""
    base_title = t "base_title"
    if page_title.empty?
      base_title
    else page_title + " | " + base_title
    end
  end

  def find_food_restaurant id
    @food = Food.where("foods.restaurant_id = #{id}")
  end

  def find_food id
    @food = Food.find_by_id id
  end

  def find_img_food id
    @images = Image.where("images.imageable_id = #{id}")
  end

  def find_restaurant id
    @restaurant = Restaurant.find_by id: "#{id}"
  end

  def find_order_detail od_id
    @order_detail = OrderDetail.find_by_id od_id
  end

  def current_order
    if !session[:order_id].nil?
      Order.find_by_id session[:order_id]
    else
      Order.new
    end
  end
end
