class Restaurant < ApplicationRecord
  belongs_to :user
  has_many :suggests
  has_many :images, as: :imageable
  has_many :foods, dependent: :destroy
  has_many :notifications
  has_many :relationships, dependent: :destroy
  has_many :users, through: :relationships

  scope :sort_restaurants, (lambda do
    select(:id, :name, :description, :address, :phone_number, :user_id)
    .order :name
  end)
  scope :search_restaurants, (lambda do |search|
    where "name LIKE :search OR address LIKE :search", search: "%#{search}%"
  end)
  scope :by_city, ->(city){where "address LIKE ?", "%#{city}"}
end
