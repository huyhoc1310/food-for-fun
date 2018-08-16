class Relationship < ApplicationRecord
  belongs_to :follower, class_name: User.name, foreign_key: :user_id
  belongs_to :followed, class_name: Restaurant.name, foreign_key: :restaurant_id
  validates :user_id, presence: true
  validates :restaurant_id, presence: true
end
