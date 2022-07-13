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

  test 'post with max 10 photos is valid' do
    assert_nil @photo.validate_max_photo
  end

  test 'invalid photo without image' do
    @photo.image = nil
    assert_not @photo.valid?
  end

  test 'invalid photo with huge size image' do
    @photo.image = fixture_file_upload('assets/big_file.jpeg', 'image/jpeg')
    assert_not @photo.valid?
    assert_equal 'Image size must be smaller than 5 MB', @photo.errors.full_messages[0]
  end

  test 'invalid photo with invalid pic format' do
    @photo.image = fixture_file_upload('assets/about.html', 'image/jpeg')
    assert_not @photo.valid?
    assert_equal 'Image format is invalid. Choose JPG, PNG or JPEG', @photo.errors.full_messages[0]
  end

  test 'post with more than 10 photos is invalid' do
    assert_not @photo2.valid?
    assert_equal 'Image count should be less than or equall to 10', @photo2.errors.full_messages[0]
  end
end
