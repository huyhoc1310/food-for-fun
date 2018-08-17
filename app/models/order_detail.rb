class OrderDetail < ApplicationRecord
  belongs_to :order, foreign_key: :order_id, optional: true
  belongs_to :food, foreign_key: :food_id, optional: true

  before_save :set_price
  before_save :set_total_price

  scope :list_order_details, (lambda do |id|
    joins(:order).select("orders.id as id, order_details.id as od_id, order_details.total_price as total, order_details.quantity as quantity, order_details.food_id as f_id")
      .where("orders.user_id= #{id} and orders.status = 'unordered'")
  end)

  scope :find_order_detail, (lambda do |f_id, u_id|
    joins(:order).select("order_details.id as id, order_details.quantity as quantity, order_details.order_id as order_id, order_details.price as price").where("order_details.food_id = #{f_id} and orders.user_id = #{u_id} and orders.status = 'unordered'")
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

  private

  def set_price
    self[:price] = price
  end

  def set_total_price
    self[:total_price] = quantity * set_price
  end
end
