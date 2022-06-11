# frozen_string_literal: true

class StoriesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_story, only: %i[destroy]

  def index
    @pagy, @stories = pagy(Story.order('created_at desc'), page: params[:page], items: 5)
  end

  def create
    @story = current_user.stories.new(story_params)
    @story.save!
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.record.errors.full_messages
  else
    flash[:notice] = 'Story has been saved.'
    DeleteStoryJob.set(wait: 10.seconds).perform_later(@story)
  ensure
    redirect_to stories_path
  end

  def destroy
    authorize @story
    @story.destroy!
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.record.errors.full_messages
  else
    flash[:notice] = 'Story deleted!'
  ensure
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
