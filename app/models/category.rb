class Category < ApplicationRecord
  belongs_to :parent, class_name: Category.name, optional: true
  has_many :subcategories, class_name: Category.name, foreign_key: :parent_id,
    dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  has_many :foods
  belongs_to :restaurant, foreign_key: :restaurant_id

  validates :name, presence: true,
    length: {maximum: Settings.model.categories.name.maximum}

  scope :load_parents, ->{where("parent_id is null")}
end
