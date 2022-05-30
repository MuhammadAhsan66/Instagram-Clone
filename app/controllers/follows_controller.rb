class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def create
    if current_user.follow(@user.id)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js
      end
    end
  end

  def destroy
    if current_user.unfollow(@user.id)
      respond_to do |format|
        format.html { redirect_to @user }
        format.js { render action: :create }
      end
    end
  end

  private

  def set_user
    # @user = User.find_by(username: params[:user_username])
    @user = User.find(params[:user_id])
  rescue ActiveRecord::RecordNotFound
    render 'user_not_found'
  end
end
