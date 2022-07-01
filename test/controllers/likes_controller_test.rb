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

  test 'does create like' do
    assert_difference('Like.count') do
      post post_likes_url(@post, format: :js)
    end
  end

  test 'does destroy like' do
    assert_difference('Like.count', -1) do
      delete like_url(@like, format: :js)
    end
  end
end
