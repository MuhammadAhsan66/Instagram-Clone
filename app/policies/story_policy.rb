class StoryPolicy
  include Pundit::Authorization
  attr_reader :user, :story

  def initialize(user, story)
    @user = user
    @story = story
  end

  def destroy?
    user.owner? story, user
  end
end
