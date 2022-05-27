class PostsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[show destroy edit update]

  def index
    @posts = Post.all.limit(1000).includes(:photos, :user, :likes, :comments).order('created_at desc')
    # @posts = Post.all.order('created_at desc')
    @post = Post.new
  end

  def create
    @post = current_user.posts.new(post_params)
    ActiveRecord::Base.transaction do
      @post.save
    end
  rescue ActiveRecord::RecordInvalid
    render 'post_cannot_save'
  else
    save_photo
    redirect_to posts_path
    flash[:notice] = 'Post has been saved.'
  end

  def update
    ActiveRecord::Base.transaction do
      @post.update(post_params)
    end
  rescue ActiveRecord::RecordInvalid
    render 'post_cannot_save'
  else
    save_photo
    redirect_to @post
    flash[:notice] = 'Post has been Updated.'
  end

  def destroy
    ActiveRecord::Base.transaction do
      @post.destroy
    end
  rescue ActiveRecord::RecordInvalid
    render 'post_cannot_save'
  else
    flash[:notice] = 'Post deleted!'
  end

  def show
    @photos = @post.photos
    @likes = @post.likes.includes(:user)
    @comments = Comment.new
  end

  def edit; end

  private

  def find_post
    @post = Post.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render 'post_not_found'
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
