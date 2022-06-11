# frozen_string_literal: true

# app/controller/application_controlller.rb
class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  include Pundit::Authorization
  include Pagy::Backend
  before_action :configure_permitted_parameters, if: :devise_controller?
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to root_path
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[name image])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
