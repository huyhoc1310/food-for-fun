class Food < ApplicationRecord
  belongs_to :restaurant, foreign_key: :restaurant_id, optional: true
  belongs_to :category, foreign_key: :category_id, optional: true
  has_many :comments
  has_many :images, as: :imageable
  has_many :order_details, dependent: :destroy

  enum status: [:enable, :disable]

  accepts_nested_attributes_for :images, allow_destroy: true

  validates_presence_of :name, message: I18n.t("food.error.name")
  validates_presence_of :description, message: I18n.t("food.error.description")
  validates_presence_of :price, message: I18n.t("food.error.price")

  scope :category, (lambda do |id|
    joins(:category).select("categories.name as name_category")
      .where("foods.id = #{id}")
  end)
  scope :get_new_foods, (lambda do |id|
    select(:id, :name, :price, :description, :created_at)
      .where(restaurant_id: id).order(:created_at).limit Settings.new_foods_limit
  end)
  scope :get_all_foods, (lambda do |id|
    select(:id, :name, :price, :description).where(restaurant_id: id)
  end)
  scope :search_foods, ->(search){where "name LIKE ?", "%#{search}%"}
  scope :by_category, ->(id){where category_id: id}
  scope :find_food_of_restaurant, ->(id){where restaurant_id: id}

  ratyrate_rateable "score"
end
