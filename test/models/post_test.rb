# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
    @user = users(:valid)
    @like = likes(:one)
  end

  test 'valid post' do
    assert @post.valid?
  end

  test 'if a user liked the post' do
    assert_equal @like, @post.like_by(@user)
  end

  test 'if a user did not like the post' do
    assert_not @post.like_by(users(:valid2))
  end

  test 'invalid post without caption' do
    @post.caption = nil
    assert_not @post.valid?
  end

  test 'invalid post with long caption' do
    @post.caption = 'This is very long caption for a post. Maximum limit for a caption is 100 characters.
                     this caption is more than 100 characters'
    assert_not @post.valid?
  end

  test 'post has many likes' do
    assert_equal 1, @post.likes.size
  end

  test 'post has many comments' do
    assert_equal 1, @post.comments.size
  end

  test 'post has many photos' do
    assert_equal 1, @post.photos.size
  end
end
