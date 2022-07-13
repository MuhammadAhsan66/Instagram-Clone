# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:valid2)
    sign_in @user
    @post = posts(:three)
    @like = likes(:one)
  end

  test '#create' do
    assert_difference('Like.count') do
      post post_likes_url(@post, format: :js)
    end
  end

  test '#destroy' do
    assert_difference('Like.count', -1) do
      delete like_url(@like, format: :js)
    end
  end

  test 'does not #create a like twice' do
    post post_likes_url(@post, format: :js)
    post post_likes_url(@post, format: :js)
    assert_response :redirect
    assert_equal ['User has already been taken'], flash[:alert]
  end

  test 'does not #create a like on invalid post' do
    post post_likes_url(14_564_564_564, format: :js)
    assert_response :redirect
    assert_equal ['Post must exist'], flash[:alert]
  end

  test 'does not #destroy invalid like' do
    assert_no_difference('Like.count', -1) do
      delete like_url(10, format: :js)
    end
    assert_equal 'Record Not Found', flash[:alert]
  end
end
