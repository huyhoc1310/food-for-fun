class Restaurant < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_many :suggests
  has_many :images, as: :imageable
  has_many :foods, dependent: :destroy
  has_many :notifications
  has_many :relationships, dependent: :destroy
  has_many :users, through: :relationships
end
