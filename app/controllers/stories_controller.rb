# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story, only: %i[destroy]

  def create
    @story = Story.new(story_params)
    @story.save!
    flash[:notice] = 'Story has been saved.'
    DeleteStoryJob.set(wait: 1.day).perform_later(@story)
    redirect_to stories_path
  end

  def destroy
    authorize @story
    @story.destroy!
    flash[:notice] = 'Story deleted!'
    redirect_to stories_path
  end

  private

  def set_story
    @story = Story.find(params[:id])
  end

  def story_params
    params.require(:story).permit(:caption, :story_pic, :user_id)
  end
end
