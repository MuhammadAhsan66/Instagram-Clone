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
end
