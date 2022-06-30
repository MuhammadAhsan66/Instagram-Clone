# frozen_string_literal: true

require 'test_helper'

class PhotoTest < ActiveSupport::TestCase
  def setup
    @photo = photos(:one)
    @photo2 = photos(:two)
  end

  test 'valid photo' do
    assert @photo.valid?
  end

  test 'invalid photo without image' do
    @photo.image = nil
    assert_not @photo.valid?
  end

  test 'post with max 10 photos is valid' do
    assert_nil @photo.validate_max_photo
  end

  test 'post with more than 10 photos is invalid' do
    assert_not_nil @photo2.validate_max_photo
  end
end
