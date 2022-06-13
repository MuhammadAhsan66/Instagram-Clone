# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: %i[edit destroy]

  def index
    @requests = current_user.follower_relationships.where(status: 'pending')
  end

  def edit
    @request.update!(status: 'accepted')
  rescue ActiveRecord::RecordNotDestroyed => e
    flash[:alert] = e.record.errors.full_messages
  else
    flash[:notice] = 'Request Accepted!'
    redirect_to requests_path
  end

  def destroy
    @request.destroy!
  rescue ActiveRecord::RecordNotDestroyed => e
    flash[:alert] = e.record.errors.full_messages
  else
    flash[:notice] = 'Request Deleted!'
    redirect_to requests_path
  end

  private

  def set_request
    @request = Follow.find_by(id: params[:id])
  end
end
