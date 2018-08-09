class Suggest < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  belongs_to :restaurant, foreign_key: :restaurant_id

  validates :title, presence: true,
                   length: {maximum: Settings.model.suggests.title.maximum}
  validates :content, presence: true
end
