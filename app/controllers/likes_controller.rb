# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: %i[destroy]

  def create
    @like = current_user.likes.new(like_params)
    @post = @like.post
    if @like.save
      respond_to :js
    else
      flash[:alert] = 'Something went wrong while liking this post'
    end
  end

  def destroy
    @post = @like.post
    if @like.destroy
      respond_to :js
    else
      flash[:alert] = 'Something went wrong while unliking this post'
    end
  end

  private

  def set_like
    @like = Like.find_by(id: params[:id])
  end

  def like_params
    params.permit(:post_id, :user_id)
  end
end
