# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story, only: %i[destroy]

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
    DeleteStoryJob.set(wait: 30.seconds).perform_later(@story)
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

  private

  def set_story
    @story = Story.find_by(id: params[:id])
  end

  def story_params
    params.require(:story).permit(:caption, :story_pic)
  end
end
