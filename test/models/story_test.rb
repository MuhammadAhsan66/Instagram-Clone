# frozen_string_literal: true

require 'test_helper'

class StoryTest < ActiveSupport::TestCase
  def setup
    @story = stories(:one)
  end

  test 'valid story' do
    assert @story.valid?
  end

  test 'invalid story without pic' do
    @story.story_pic = nil
    assert_not @story.valid?
  end

  test 'invalid story with invalid pic format' do
    @story.story_pic = 'invalid.pdf'
    assert_not @story.valid?
  end

  test 'invalid story without caption' do
    @story.caption = nil
    assert_not @story.valid?
  end

  test 'invalid story with long caption' do
    @story.caption = 'This is very long caption for a post. Maximum limit for a caption is 100 characters.
                      this caption is more than 100 characters'
    assert_not @story.valid?
  end
end
