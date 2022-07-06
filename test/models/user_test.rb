# frozen_string_literal: true

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:valid)
    @user2 = users(:valid2)
  end

  test 'valid user' do
    assert @user.valid?
  end

  test 'invalid user without email' do
    @user.email = nil
    assert_not @user.valid?
  end

  test 'invalid user with invalid email' do
    @user.email = 'invalid.gmail.com'
    assert_not @user.valid?
  end

  test 'invalid user without name' do
    @user.name = nil
    assert_not @user.valid?
  end

  test 'invalid user with long name' do
    @user.name = 'This is a very long name for a user. User name should be of 50 character maximum.'
    assert_not @user.valid?
  end

  test 'invalid user without name and email both' do
    @user.name = nil
    @user.email = nil
    assert_not @user.valid?
  end

  test 'user has many post' do
    assert_equal 2, @user.posts.size
  end

  test 'user can like a post' do
    assert_equal 2, @user.likes.size
  end

  test 'user can comment on a post' do
    assert_equal 2, @user.comments.size
  end

  test 'user has many stories' do
    assert_equal 2, @user.stories.size
  end
end
