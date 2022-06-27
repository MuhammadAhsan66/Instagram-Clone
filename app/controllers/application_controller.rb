# frozen_string_literal: true

# app/controller/application_controlller.rb
class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end

  def record_not_found
    flash[:alert] = 'Record Not Found'
    redirect_to root_path
  end

  def unprocessable_entity(err)
    flash[:alert] = err.record.errors.full_messages
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name image account_type])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[name account_type])
  end
end
