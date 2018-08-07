class Image < ApplicationRecord
  attr_accessor :image
  belongs_to :imageable, polymorphic: true, optional: true
  mount_uploader :image, ImageUploader
end
