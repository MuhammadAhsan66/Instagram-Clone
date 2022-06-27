# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user!
  def index
    @users = User.search(params[:term])
  end

  def show
    @user = User.find(params[:id])
    @user.image = @user == current_user ? 'current_user_pic.png' : 'users_pic.png'
  end
end
