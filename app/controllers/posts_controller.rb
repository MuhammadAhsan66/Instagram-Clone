# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show edit update destroy]

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    post_serivce = PostService.new(params, @post)
    ActiveRecord::Base.transaction do
      @post.save!
      post_serivce.save_photo
    end
    flash[:notice] = 'Post has been saved.'
    redirect_to @post
  end

  def show
    authorize @post
  end

  def edit
    authorize @post
  end

  def update
    authorize @post
    @post.update!(post_params)
    flash[:notice] = 'Post has been Updated.'
    redirect_to @post
  end

  def destroy
    authorize @post
    @post.destroy!
    flash[:notice] = 'Post deleted!'
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:caption, :user_id)
  end
end
