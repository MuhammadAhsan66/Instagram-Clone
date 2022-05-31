class PostPolicy < Struct.new(:user, :post)
  include Pundit

  def edit?
    user.is_owner? post, user
  rescue Pundit::NotAuthorizedError
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end

  def update?
    user.is_owner? post, user
  rescue Pundit::NotAuthorizedError
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end

  def destroy?
    user.is_owner? post, user
  end
end
