# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, -> { order 'created_at desc' }, dependent: :destroy
  validates :caption, presence: true, length: { maximum: 100 }

  # def liked_user(user)
  def like_by(user)
    Like.find_by(user_id: user.id, post_id: id)
  end
end
