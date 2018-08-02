class Food < ApplicationRecord
  belongs_to :restaurant, foreign_key: :restaurant_id
  belongs_to :category, foreign_key: :category_id
  has_many :comments
  has_many :images, as: :imageable
  has_many :order_details
end
