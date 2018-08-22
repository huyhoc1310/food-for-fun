class Comment < ApplicationRecord
  has_many :images, as: :imageable, dependent: :destroy
  belongs_to :parent, class_name: Comment.name, optional: true
  has_many :replies, class_name: Comment.name, foreign_key: :parent_id,
    dependent: :destroy
  belongs_to :user, foreign_key: :user_id
  belongs_to :food, foreign_key: :food_id

  accepts_nested_attributes_for :images, allow_destroy: true
  accepts_nested_attributes_for :replies, allow_destroy: true

  validates :content, presence: true

  scope :load_parents, ->{where("parent_id is null")}
end
