class Comment < ApplicationRecord
  has_many :images, as: :imageable
  has_many :comments, foreign: :parent_id
  belongs_to :user, foreign: :user_id
  belongs_to :food, foreign: :food_id
end
