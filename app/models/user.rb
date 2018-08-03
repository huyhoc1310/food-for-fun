class User < ApplicationRecord
  has_one :restaurant
  has_many :orders
  has_many :suggests, dependent: :destroy
  has_many :images, as: :imageable, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :relationships, dependent: :destroy
  has_many :restaurants, through: :relationships
end
