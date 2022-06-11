# frozen_string_literal: true

class Follow < ApplicationRecord
  belongs_to :follower, class_name: 'User', inverse_of: :following_relationships
  belongs_to :following, class_name: 'User', inverse_of: :follower_relationships
end
