# frozen_string_literal: true

module PostsHelper
  def posts
    Post.includes(:photos, :user, :likes, :comments)
  end

  def comments(post)
    post.comments.includes(:user, :post)
  end

  def stories
    Story.includes(:user)
  end
end
