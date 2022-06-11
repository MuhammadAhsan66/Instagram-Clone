class CommentPolicy
  include Pundit::Authorization
  attr_reader :user, :comment

  def initialize(user, comment)
    @user = user
    @comment = comment
  end

  def edit?
    user.commnet_owner? comment, user
  end

  def update?
    user.commnet_owner? comment, user
  end

  def destroy?
    user.commnet_owner? comment, user
  end
end
