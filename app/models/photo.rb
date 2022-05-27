class Photo < ApplicationRecord
  belongs_to :post
  validates :image, presence: true
  mount_uploader :image, PhotoUploader
  validates :image, file_size: { less_than: 1.megabytes, message: 'Image should be less than 1 MB' }
end
