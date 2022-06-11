# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern

  def owner?(record, current_user)
    record.user_id == current_user.id
  end

  def commnet_owner?(comment, current_user)
    comment.user_id == current_user.id || comment.post.user_id == current_user.id
  end
end
