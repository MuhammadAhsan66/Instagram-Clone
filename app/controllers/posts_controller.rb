# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_post, only: %i[show destroy edit update]
  before_action :authorize_post, only: %i[destroy edit update]

  def index
    @posts = Post.all.includes(:photos, :user, :likes, :comments).order('created_at desc')
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    ActiveRecord::Base.transaction do
      @post.save!
      save_photo
    end
  rescue ActiveRecord::RecordInvalid
    render 'post_cannot_save'
  else
    flash[:notice] = 'Post has been saved.'
    redirect_to posts_path
  end

  def update
    ActiveRecord::Base.transaction do
      @post.update!(post_params)
      save_photo
    end
  rescue ActiveRecord::RecordInvalid
    render 'post_cannot_save'
  else
    flash[:notice] = 'Post has been Updated.'
    redirect_to @post
  end

  def destroy
    ActiveRecord::Base.transaction do
      @post.destroy!
    end
  rescue ActiveRecord::RecordInvalid
    render 'post_cannot_save'
  else
    flash[:notice] = 'Post deleted!'
    redirect_to root_path
  end

  private

  def set_post
    @post = Post.find_by(id: params[:id])
  end

  def post_params
    params.require(:post).permit(:caption)
  end

  def save_photo
    params[:photos_list].each do |img|
      @post.photos.create!(image: img)
    end
  end

  def authorize_post
    authorize @post
  rescue Pundit::NotAuthorizedError
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to @post
  end
end
