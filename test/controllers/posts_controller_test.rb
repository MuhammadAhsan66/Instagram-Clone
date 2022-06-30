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

  test 'should get new' do
    get new_post_url
    assert_response :success
  end

  test 'should create post' do
    img = fixture_file_upload('assets/14.jpeg', 'image/jpeg')
    assert_difference('Post.count') do
      post posts_url, params: { post: { caption: 'new post', user_id: @user.id }, photos_list: [img] }
    end
    assert_redirected_to post_url(Post.last)
  end

  test 'should show post' do
    get post_url(@post)
    assert_response :success
  end

  test 'should get edit' do
    get edit_post_url(@post)
    assert_response :success
  end

  test 'should update post' do
    patch post_url(@post), params: { post: { caption: 'updated caption', user_id: @user.id } }
    assert_redirected_to post_url(@post)
  end

  test 'should destroy post' do
    assert_difference('Post.count', -1) do
      delete post_url(@post)
    end
    assert_redirected_to root_path
  end

  # ------ Negative Tests ------

  test 'should not create a post with huge size photo' do
    img = fixture_file_upload('assets/big_file.jpeg', 'image/jpeg')
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { caption: 'new post', user_id: @user.id }, photos_list: [img] }
    end
    assert_redirected_to root_path
  end

  test 'should not create a post with long caption' do
    img = fixture_file_upload('assets/14.jpeg', 'image/jpeg')
    cap = 'This is very long caption for a post. Maximum limit for a caption is 100 characters.
           this caption is more than 100 characters'
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { caption: cap, user_id: @user.id }, photos_list: [img] }
    end
    assert_redirected_to root_path
  end

  test 'should not create a post with invalid photo format' do
    img = fixture_file_upload('assets/about.html')
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { caption: 'new post', user_id: @user.id }, photos_list: [img] }
    end
    assert_redirected_to root_path
  end

  test 'should not create a post with more than 10 photos' do
    img = Array.new(11) { fixture_file_upload('assets/14.jpeg', 'image/jpeg') }
    assert_no_difference('Post.count') do
      post posts_url, params: { post: { caption: 'new post', user_id: @user.id }, photos_list: img }
    end
    assert_redirected_to root_path
  end

  test 'should not show un identified post' do
    get post_url(10)
    assert_response :redirect
  end

  test 'should not show unauthorize post' do
    get post_url(@post2)
    assert_response :redirect
  end

  test 'should not get edit of un identified post' do
    get edit_post_url(10)
    assert_response :redirect
  end

  test 'should not get edit of unauthorize post' do
    get edit_post_url(@post2)
    assert_response :redirect
  end

  test 'should not update un identified post' do
    patch post_url(10), params: { post: { caption: 'updated caption', user_id: @user.id } }
    assert_redirected_to root_path
  end

  test 'should not update unauthorize post' do
    patch post_url(@post2), params: { post: { caption: 'updated caption', user_id: @user.id } }
    assert_redirected_to root_path
  end

  test 'should not destroy un identified post' do
    assert_no_difference('Post.count', -1) do
      delete post_url(10)
    end
    assert_redirected_to root_path
  end

  test 'should not destroy unauthorize post' do
    assert_no_difference('Post.count', -1) do
      delete post_url(@post2)
    end
    assert_redirected_to root_path
  end

  # ------ Side Effects -------

  test 'should create user' do
    sign_out @user
    assert_difference('User.count') do
      post user_registration_url, params: { user: { name: 'new user', email: 'new@gmail.com', password: '12345678',
                                                    password_confirmation: '12345678', image: 'temp.jpg' } }
    end
  end
end
