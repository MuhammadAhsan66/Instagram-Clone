# frozen_string_literal: true

# app/controller/application_controlller.rb
class ApplicationController < ActionController::Base
  # protect_from_forgery with: :exception
  include Pundit::Authorization
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name])
  end
end
