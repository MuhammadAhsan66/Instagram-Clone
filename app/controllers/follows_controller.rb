# frozen_string_literal: true

class FollowsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user, only: %i[create destroy]

  def create
    if current_user.follow(@user.id)
      respond_to :js
    end
  end

  def destroy
    if current_user.unfollow(@user.id)
      respond_to do |format|
        format.js { render action: :create }
      end
    end
  end

  private

  def set_user
    @user = User.find_by(id: params[:user_id])
  end
end
