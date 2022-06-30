# frozen_string_literal: true

require 'test_helper'

class PostTest < ActiveSupport::TestCase
  def setup
    @post = posts(:one)
    @user = users(:valid)
  end

  test 'valid post' do
    assert @post.valid?
  end

  test 'post can be liked by a user' do
    assert @post.like_by(@user)
  end

  test 'invalid post without caption' do
    @post.caption = nil
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
