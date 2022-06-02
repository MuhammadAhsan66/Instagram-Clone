# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[destroy]

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      @post = @comment.post
      respond_to :js
    else
      flash[:alert] = 'Something went wrong while commenting'
    end
  end

  def destroy
    @post = @comment.post
    if @comment.destroy
      respond_to :js
    else
      flash[:alert] = 'Something went wrong while deleting comment'
    end
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.required(:comment).permit(:user_id, :post_id, :body)
  end
end
