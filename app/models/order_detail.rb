class OrderDetail < ApplicationRecord
  belongs_to :order, foreign_key: :order_id, optional: true
  belongs_to :food, foreign_key: :food_id, optional: true
  belongs_to :restaurant, foreign_key: :restaurant_id, optional: true

  before_save :set_price
  before_save :set_total_price
  before_save :set_restaurant_id

  scope :list_order_details, (lambda do |id|
    joins(:order).select("orders.id as id, order_details.id as od_id, order_details.total_price as total, order_details.quantity as quantity, order_details.food_id as f_id")
      .where("orders.user_id= #{id} and orders.status = 0")
  end)

  scope :find_order_detail, (lambda do |f_id, _u_id|
    joins(:order).select(:id, :quantity, :order_id, :price)
    .where food_id: f_id, orders: {status: 0}
  end)

  scope :find_or_detail, ->(id){where order_id: id}

  scope :get_revenue, (lambda do |restaurant|
    joins(:restaurant).where(restaurant_id: restaurant.id)
      .group_by_day("order_details.created_at").sum(:total_price)
  end)

  def price
    if persisted?
      self[:price]
    else
      food.price
    end
  end

  def total_price
    price * quantity
  end

  def restaurant_id
    if persisted?
      self[:restaurant_id]
    else
      food.restaurant_id
    end
  end

  private

  def set_price
    self[:price] = price
  end

  def set_total_price
    self[:total_price] = quantity * set_price
  end

  def set_restaurant_id
    self[:restaurant_id] = restaurant_id
  end
end
