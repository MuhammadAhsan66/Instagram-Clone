class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])

    if @user == current_user
      @user.image = 'current_user_pic'
    else
      @user.image = 'users_pic'
    end
  end
end
