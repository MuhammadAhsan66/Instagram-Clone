# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[create destroy]

  def create
    respond_to :js if current_user.follow(@user.id)
  end

  def destroy
    return unless current_user.unfollow(@user.id)

    respond_to do |format|
      format.js { render action: :create }
    end
  end

  private

  def set_user
    @user = User.find(params[:user_id])
  end
end
