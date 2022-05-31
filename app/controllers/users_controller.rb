# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.search(params[:term])
    respond_to :js
  end

  def show
    @user = User.find(params[:id])
    @user.image = @user == current_user ? 'current_user_pic' : 'users_pic'
  rescue ActiveRecord::RecordNotFound
    render 'user_not_found'
  end
end
