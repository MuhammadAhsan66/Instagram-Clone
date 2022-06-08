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

  def edit; end

  def update
    @comment.update!(comment_params)
  rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = e.record.errors.full_messages
  ensure
    redirect_to @comment.post
  end

  def destroy
    @post = @comment.post
    @comment.destroy!
  rescue ActiveRecord::RecordNotDestroyed => e
    flash.now[:alert] = e.record.errors.full_messages
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
