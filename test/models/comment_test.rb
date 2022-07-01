# frozen_string_literal: true

require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  def setup
    @comment = comments(:one)
  end

  test 'valid comment' do
    assert @comment.valid?
  end

  test 'invalid comment without body' do
    @comment.body = nil
    assert_not @comment.valid?
  end

  test 'invalid comment with long body' do
    @comment.body = 'This is very long caption for a post. Maximum limit for a caption is 100 characters.
                      this caption is more than 100 characters'
    assert_not @comment.valid?
  end
end
