# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[edit update destroy]

  def create
    @comment = Comment.new(comment_params)
    @post = @comment.post
    @comment.save!
  rescue ActiveRecord::RecordInvalid => invalid
    flash.now[:alert] = invalid.record.errors.full_messages
  ensure
    respond_to :js
  end

  def edit
  end

  def update
  end

  def destroy
    @post = @comment.post
    @comment.destroy!
  rescue ActiveRecord::RecordNotDestroyed => invalid
    flash.now[:alert] = invalid.record.errors.full_messages
  ensure
    respond_to :js
  end

  private

  def set_comment
    @comment = Comment.find_by(id: params[:id])
  end

  def comment_params
    params.required(:comment).permit(:user_id, :post_id, :body)
  end
end
