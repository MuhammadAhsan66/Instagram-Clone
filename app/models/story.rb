# frozen_string_literal: true

class Story < ApplicationRecord
  mount_uploader :story_pic, PhotoUploader

  belongs_to :user
end
