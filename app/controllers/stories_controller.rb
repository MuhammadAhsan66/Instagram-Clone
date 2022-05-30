class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :find_story, only: %i[destroy]

  def index
    @stories = Story.all.limit(1000).includes(:user).order('created_at desc')
    @story = Story.new
  end

  def create
    @story = current_user.stories.new(story_params)
    ActiveRecord::Base.transaction do
      @story.save!
    end
  rescue ActiveRecord::RecordInvalid
    render 'story_cannot_save'
  else
    flash[:notice] = 'Story has been saved.'
    DeleteStoryJob.set(wait: 20.second).perform_later(@story)
    redirect_to stories_path
  end

  def destroy
    ActiveRecord::Base.transaction do
      @story.destroy!
    end
  rescue ActiveRecord::RecordInvalid
    render 'story_cannot_save'
  else
    flash[:notice] = 'Story deleted!'
    redirect_to stories_path
  end

  # def update
  #   ActiveRecord::Base.transaction do
  #     @post.update!(story_params)
  #     save_photo
  #   end
  # rescue ActiveRecord::RecordInvalid
  #   render 'post_cannot_save'
  # else
  #   flash[:notice] = 'Post has been Updated.'
  #   redirect_to @post
  # end


  # def show
  #   @photos = @post.photos
  #   @likes = @post.likes.includes(:user)
  #   @comments = Comment.new
  # end

  # def edit; end

  private

  def find_story
    @story = Story.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render 'story_not_found'
  end

  def story_params
    params.require(:story).permit(:caption, :story_pic)
  end
end
