# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_post, only: %i[destroy]

  def index
    @comments = @post.comments.includes(:user)
  end

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

  def find_post
    @comment = Comment.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render 'comment_not_found'
  end

  def comment_params
    params.required(:comment).permit(:user_id, :post_id, :body)
  end
end
