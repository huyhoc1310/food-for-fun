class Order < ApplicationRecord
  belongs_to :user, foreign_key: :user_id
  has_one :notification
  has_many :order_details, dependent: :destroy

  enum status: [:unordered, :ordered, :received]

end
