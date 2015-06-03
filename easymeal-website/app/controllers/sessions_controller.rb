# -*- encoding : utf-8 -*-
class SessionsController < ApplicationController
  protect_from_forgery except: :create
  
  def create
    user = User.find_by_username(params[:user][:username].downcase) if params[:user]
    user = User.find_by_email(params[:user][:email].downcase) if user.nil? && params[:user]
    if user && user.valid_password?(params[:user][:password])
      sign_in(:user, user)
      # current_user = user
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { render json: { status: "OK", data: { auth_token: user.auth_token, user: user }, message: nil } }
      end
    else
      flash.now[:error] = 'Username and password don\'t match'
      respond_to do |format|
        format.html { render :new }
        format.json { render json: { status: "KO", data: nil, message: 'Username and password don\'t match' } }
      end
    end
  end
  
end
