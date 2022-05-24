class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  validates_length_of :photos, maximum: 10
end
