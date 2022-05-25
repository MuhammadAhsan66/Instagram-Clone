class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, -> { order 'created_at desc' }
  validates_length_of :photos, maximum: 10
end
