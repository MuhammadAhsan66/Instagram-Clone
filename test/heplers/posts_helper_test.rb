# frozen_string_literal: true

require 'test_helper'

class PostsHelperTest < ActionView::TestCase
  test 'should return posts with preloading' do
    assert_instance_of(Post, posts.first)
  end

  test 'should return stories with preloading' do
    assert_instance_of(Story, stories.first)
  end
end
