# frozen_string_literal: true

class DeleteStoryJob < ApplicationJob
  queue_as :default

  def perform(story)
    story&.destroy!
  rescue ActiveRecord::RecordInvalid => e
    flash[:alert] = e.record.errors.full_messages
  end
end
