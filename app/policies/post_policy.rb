class PostPolicy
  include Pundit::Authorization
  attr_reader :user, :post

  def initialize(user, post)
    @user = user
    @post = post
  end

  def edit?
    user.owner? post, user
  end

  def update?
    user.owner? post, user
  end

  def destroy?
    user.owner? post, user
  end
end
