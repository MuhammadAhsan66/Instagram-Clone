class PostPolicy < Struct.new(:user, :post)
  include Pundit::Authorization

  def edit?
    user.is_owner? post, user
  end

  def update?
    user.is_owner? post, user
  end

  def destroy?
    user.is_owner? post, user
  end
end
