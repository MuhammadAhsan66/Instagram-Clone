class DeleteStoryJob < ApplicationJob
  queue_as :default

  def perform(story)
    ActiveRecord::Base.transaction do
      if story
        story.destroy!
      end
    end
  rescue ActiveRecord::RecordInvalid
    render 'stories/story_cannot_save'
  end
end
