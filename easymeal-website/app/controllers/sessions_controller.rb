class SessionsController < ApplicationController
  protect_from_forgery except: :create
  
  def create
    user = User.find_by_username(params[:user][:username].downcase) if params[:user]
    user = User.find_by_email(params[:user][:username].downcase) if user.nil? && params[:user]
    if user && user.valid_password?(params[:user][:password])
      sign_in(:user, user)
      # current_user = user
      respond_to do |format|
        format.html { redirect_to root_path }
        format.json { 
          render json: {
            "message" => "authentication succeeded.", auth_token: current_user.auth_token, user: user
            }
        }
      end
    else
      flash.now[:error] = 'Username and password don\'t match'
      respond_to do |format|
        format.html { render :new }
        format.json { render json: {"user" => "authentication needed.", "message" => 'Username and password don\'t match' } }
      end
    end
  end
  
end
