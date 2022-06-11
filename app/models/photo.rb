# frozen_string_literal: true

class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader

  belongs_to :post
  validates :image, presence: true
  validates :image, file_size: { less_than: 5.megabytes, message: "size must be smaller than 5 MB" }
  validates_format_of :image, with: /([^\s]+(\.(?i)(jpg|png|jpeg))$)/, message: "format is invalid. Choose JPG, PNG or JPEG"
  validate :validate_max_photo

  def validate_max_photo
    return unless post && post.photos.count >= 10

    errors.add(:image, "count should be less than or equall to 10")
  end
end
