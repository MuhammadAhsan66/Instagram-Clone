# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!
  before_action :set_like, only: %i[destroy]

  def create
    @like = current_user.likes.new(like_params)
    @post = @like.post
    @like.save!
    respond_to :js
  end

  def destroy
    @post = @like.post
    @like.destroy!
    respond_to :js
  end

  private

  def set_like
    @like = Like.find(params[:id])
  end

  def like_params
    params.permit(:post_id, :user_id)
  end
end
