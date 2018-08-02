class OderDetail < ApplicationRecord
  belongs_to :order, foreign_key: :order_id
  belongs_to :food, foreign_key: :food_id
end
