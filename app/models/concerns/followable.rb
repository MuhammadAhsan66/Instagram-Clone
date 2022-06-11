# frozen_string_literal: true

module Followable
  extend ActiveSupport::Concern

  included do
    has_many :follower_relationships, foreign_key: :following_id, class_name: 'Follow', dependent: :destroy
    has_many :followers, through: :follower_relationships, source: :follower, dependent: :destroy

    has_many :following_relationships, foreign_key: :follower_id, class_name: 'Follow', dependent: :destroy
    has_many :following, through: :following_relationships, source: :following, dependent: :destroy
  end

  def follow(user_id)
    following_relationships.create(following_id: user_id)
  end

  def unfollow(user_id)
    following_relationships.find_by(following_id: user_id).destroy
  end

  def following?(user_id)
    relationship = Follow.find_by(follower_id: id, following_id: user_id)
    return true if relationship

    # Follow.find_by(follower_id: id, following_id: user_id).any?
  end
end
