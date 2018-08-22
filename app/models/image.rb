class Image < ApplicationRecord
  attr_accessor :image
  belongs_to :imageable, polymorphic: true, optional: true
  mount_uploader :image, ImageUploader

  scope :find_image_food, ->(id){where imageable_id: id}
end
