class UsersController < ApplicationController
  def show
    begin
      @user = User.find(params[:id])
    rescue ActiveRecord::RecordNotFound
      render 'usernotfound'
    else
      @user.image = @user == current_user ? 'current_user_pic' : 'users_pic'
    end
  end
end
