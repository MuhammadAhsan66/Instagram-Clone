class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, -> { order 'created_at desc' }, dependent: :destroy
  validates_length_of :photos, maximum: 10

  def liked_user(user)
    Like.find_by(user_id: user.id, post_id: id)
  end
end
