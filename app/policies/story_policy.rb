# frozen_string_literal: true

class StoryPolicy
  include Pundit::Authorization
  attr_reader :user, :story

  def initialize(user, story)
    @user = user
    @story = story
  end

  def show?
    user.view? story, user
  end

  def destroy?
    user.owner? story, user
  end
end
