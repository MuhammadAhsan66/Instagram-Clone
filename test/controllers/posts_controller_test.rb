# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:valid)
    sign_in @user
    @post = posts(:one)
    @post2 = posts(:three)
  end

  # ------ Postive Tests --------

  test 'does get new' do
    get new_post_url
    assert_response :success
  end

  test 'does create post' do
    img = fixture_file_upload('assets/14.jpeg', 'image/jpeg')
    assert_difference('Post.count') do
      post posts_url, params: { post: { caption: 'new post', user_id: @user.id }, photos_list: [img] }
    end
    assert_equal 'Post has been saved.', flash[:notice]
    assert_redirected_to post_url(Post.last)
  end

  test 'does show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'does get edit' do
    get edit_post_url(@post)
    assert_response :success
  end

  test 'does update post' do
    patch post_url(@post), params: { post: { caption: 'updated caption', user_id: @user.id } }
    assert_equal 'Post has been Updated.', flash[:notice]
    assert_redirected_to post_url(@post)
  end

  test 'does destroy post' do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end
    assert_equal 'Post deleted!', flash[:notice]
    assert_redirected_to root_path
  end

  # ------ Negative Tests ------

  test 'does not create a post with huge size photo' do
    img = fixture_file_upload('assets/big_file.jpeg', 'image/jpeg')
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { caption: 'new post', user_id: @user.id }, photos_list: [img] }
    end
    assert_equal ['Image size must be smaller than 5 MB'], flash[:alert]
    assert_redirected_to root_path
  end

  test 'does not create a post with long caption' do
    img = fixture_file_upload('assets/14.jpeg', 'image/jpeg')
    cap = 'This is very long caption for a post. Maximum limit for a caption is 100 characters.
           this caption is more than 100 characters'
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { caption: cap, user_id: @user.id }, photos_list: [img] }
    end
    assert_equal ['Caption is too long (maximum is 100 characters)'], flash[:alert]
    assert_redirected_to root_path
  end

  test 'does not create a post with invalid photo format' do
    img = fixture_file_upload('assets/about.html')
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { caption: 'new post', user_id: @user.id }, photos_list: [img] }
    end
    assert_equal ['Image format is invalid. Choose JPG, PNG or JPEG'], flash[:alert]
    assert_redirected_to root_path
  end

  test 'does not create a post with more than 10 photos' do
    img = Array.new(11) { fixture_file_upload('assets/14.jpeg', 'image/jpeg') }
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { caption: 'new post', user_id: @user.id }, photos_list: img }
    end
    assert_equal ['Image count should be less than or equall to 10'], flash[:alert]
    assert_redirected_to root_path
  end

  test 'does not show un identified post' do
    get post_url(10)
    assert_response :redirect
    assert_equal 'Record Not Found', flash[:alert]
  end

  test 'does not show unauthorize post' do
    get post_url(@post2)
    assert_response :redirect
    assert_equal 'You are not authorized to perform this action.', flash[:alert]
  end

  test 'does not get edit of un identified post' do
    get edit_post_url(10)
    assert_response :redirect
  end

  test 'does not get edit of unauthorize post' do
    get edit_post_url(@post2)
    assert_response :redirect
  end

  test 'does not update un identified post' do
    patch post_url(10), params: { post: { caption: 'updated caption', user_id: @user.id } }
    assert_redirected_to root_path
  end

  test 'does not update unauthorize post' do
    patch post_url(@post2), params: { post: { caption: 'updated caption', user_id: @user.id } }
    assert_redirected_to root_path
  end

  test 'does not destroy un identified post' do
    assert_no_difference('Post.count', -1) do
      delete post_url(10)
    end
    assert_redirected_to root_path
  end

  test 'does not destroy unauthorize post' do
    assert_no_difference('Post.count', -1) do
      delete post_url(@post2)
    end
    assert_redirected_to root_path
  end

  # ------ Side Effects -------

  test 'does create user' do
    sign_out @user
    assert_difference('User.count') do
      post user_registration_url, params: { user: { name: 'new user', email: 'new@gmail.com', password: '12345678',
                                                    password_confirmation: '12345678', image: 'temp.jpg' } }
    end
  end
end
