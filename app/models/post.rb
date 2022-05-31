# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :user
  has_many :photos, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, -> { order 'created_at desc' }, dependent: :destroy

  def liked_user(user)
    Like.find_by(user_id: user.id, post_id: id)
  end
end
