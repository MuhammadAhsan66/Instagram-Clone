# frozen_string_literal: true

class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_request, only: %i[edit destroy]

  def index
    @requests = current_user.follower_relationships.where(status: 'pending')
  end

  def edit
    @request.update!(status: 'accepted')
    flash[:notice] = 'Request Accepted!'
    redirect_to requests_path
  end

  def destroy
    @request.destroy!
    flash[:notice] = 'Request Deleted!'
    redirect_to requests_path
  end

  private

  def set_request
    @request = Follow.find(params[:id])
  end
end
