class Story < ApplicationRecord
  belongs_to :user
  mount_uploader :story_pic, PhotoUploader
end
