# frozen_string_literal: true

class Story < ApplicationRecord
  mount_uploader :story_pic, PhotoUploader

  belongs_to :user
  validates :story_pic, presence: true
  validates :caption, presence: true, length: { maximum: 100 }
  validates :story_pic, file_size: { less_than: 5.megabytes, message: 'size must be smaller than 5 MB' }
  validates :story_pic, format: { with: /([^\s]+(\.(?i)(jpg|png|jpeg))$)/,
                                  message: 'format is invalid. Choose JPG, PNG or JPEG' }
end
