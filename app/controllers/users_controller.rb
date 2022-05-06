class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
    @user.image = @user == current_user ? 'current_user_pic' : 'users_pic'
  end
end
