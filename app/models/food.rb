class Food < ApplicationRecord
  belongs_to :restaurant, foreign_key: :restaurant_id, optional: true
  belongs_to :category, foreign_key: :category_id, optional: true
  has_many :comments
  has_many :images, as: :imageable
  has_many :order_details

  accepts_nested_attributes_for :images, allow_destroy: true

  validates_presence_of :name, message: I18n.t("food.error.name")
  validates_presence_of :description, message: I18n.t("food.error.description")
  validates_presence_of :price, message: I18n.t("food.error.price")
end
