# frozen_string_literal: true

class Photo < ApplicationRecord
  mount_uploader :image, PhotoUploader

  belongs_to :post, validate: true
  validates :image, presence: true
  validates :image, file_size: { less_than: 5.megabytes }
  validates_format_of :image, with: /([^\s]+(\.(?i)(jpg|png|jpeg))$)/

  LIMIT = 10
  validate do |record|
    record.validate_max_photo
  end

  def validate_max_photo
    return unless self.post

    if self.post.photos.count >= LIMIT
      errors.add(:base, :exceeded_quota)
    end
  end
end
