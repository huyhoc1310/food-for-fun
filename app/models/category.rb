class Category < ApplicationRecord
  has_many :categories, foreign_key: :parent_id
  has_many :images, as: :imageable
  has_many :foods
end
