# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post
    @comment.save!
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages
  ensure
    respond_to :js
  end

  def edit
    authorize @comment
  end

  def update
    authorize @comment
    @comment.update!(comment_params)
    redirect_to @comment.post
  end

  def destroy
    authorize @comment
    @post = @comment.post
    @comment.destroy!
    respond_to :js
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:user_id, :post_id, :body)
  end
end
