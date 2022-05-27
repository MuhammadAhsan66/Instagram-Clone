class Photo < ApplicationRecord
  belongs_to :post
  validates :image, presence: true
  mount_uploader :image, PhotoUploader
  validates :image, file_size: { less_than: 10.megabytes, message: 'Image should be less than 10 MB' }
end
