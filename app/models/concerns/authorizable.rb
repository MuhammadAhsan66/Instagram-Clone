# frozen_string_literal: true

module Authorizable
  extend ActiveSupport::Concern

  def owner?(record, current_user)
    record.user_id == current_user.id
  end

  # This function will authorize users to see post according to the post owner account type
  def view?(record, current_user)
    return true if record.user.account_type == 'public'

    record.user.account_type == 'private' && current_user.following?(record.user) || record.user_id == current_user.id
  end

  def commnet_owner?(comment, current_user)
    comment.user_id == current_user.id || comment.post.user_id == current_user.id
  end
end
