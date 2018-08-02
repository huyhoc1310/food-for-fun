class Notification < ApplicationRecord
  belongs_to :restaurant, foreign_key: :restaurant_id
  belongs_to :order, foreign_key: :order_id
end
