# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.search(params[:term])
    respond_to :js
  end

  def show
    @user = User.find_by(id: params[:id])
    return unless @user

    @user.image = @user == current_user ? 'current_user_pic.png' : 'users_pic.png'
  end
end
