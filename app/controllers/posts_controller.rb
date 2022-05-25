class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[show destroy]

  def index
    @posts = Post.all.limit(1000).includes(:photos)
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    if @post.save
      if params[:images]
        params[:images].each do |img|
          @post.photos.create(image: img)
        end
      end
      redirect_to posts_path
      flash[:notice] = 'Saved ...'
    else
      flash[:alert] = 'Something went wrong ...'
      redirect_to posts_path
    end
  end

  # def show
  #   @photos = @post.photos
  # end

  # def destroy
  # end

  private

  def find_post
    @post = Post.find_by id: params[:id]
    return if @post

    flash[:danger] = 'Post not exist!'
    redirect_to root_path
  end

  def post_params
    params.require(:post).permit(:caption)
  end
end
