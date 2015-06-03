# -*- coding: utf-8 -*-
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  before_filter :configure_permitted_parameters, if: :devise_controller?
  
  def authorize
    return unless request.format == :html
    flash[:error] = "Accès non autorisé."
    redirect_to root_path and return unless user_signed_in?
  end
    

  
  def authenticate
    return unless request.format == :json
    authenticate_or_request_with_http_token do |token, options|
      user = User.where(auth_token: token).first if User.where(auth_token: token)
      current_user = user if user
    end
  end
  
  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit(:username, :email, :password, :password_confirmation, :firstname, :lastname, :gender, :birth) }
    devise_parameter_sanitizer.for(:account_update) do |u|
          u.permit(:firstname, :lastname, :username, :email, :password, :password_confirmation, :current_password)
        end
  end
end
