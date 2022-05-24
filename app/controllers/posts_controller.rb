class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[show destroy edit update]

  def index
    # @posts = Post.all.limit(1000).includes(:photos, :user).order('created_at desc')
    @posts = Post.all.order('created_at desc')
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      save_photo
      redirect_to posts_path
      flash[:notice] = 'Post has been saved.'
    else
      flash[:alert] = 'Something went wrong while saving the post!'
      redirect_to posts_path
    end
  end

  def update
    if @post.update(post_params)
      save_photo
      redirect_to @post
      flash[:notice] = 'Post has been updated.'
    else
      flash[:alert] = 'Something went wrong while saving the post!'
      redirect_to @post
    end
  end

  def destroy
    if @post.destroy
      flash[:notice] = 'Post deleted!'
    else
      flash[:alert] = 'Something went wrong while deleting the post!'
    end
    redirect_to root_path
  end

  def show
    @photos = @post.photos
  end

  def edit; end

  private

  def find_post
    @post = Post.find_by id: params[:id]
    return if @post

    flash[:danger] = 'Post does not exist!'
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit(:caption)
  end

  def save_photo
    params[:photos_list].each do |img|
      @post.photos.create(image: img)
    end
  end
end
