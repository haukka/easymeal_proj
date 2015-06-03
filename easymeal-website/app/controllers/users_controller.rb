# -*- encoding : utf-8 -*-
# -*- coding: utf-8 -*-
class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :authorize

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find(params[:id]) if params[:id]
    
    respond_to do |format|
      format.html { render action: :show }
      format.json { render json: { status: "OK", data: { user: @user }, message: nil } }
    end
  end
  
  # GET /users/new
  def new
    if !@user
      @user = User.new
    end
  end

  # GET /users/1/edit
  def edit
    if @user.home
      @home = @user.home
    else
      @home = Home.new
    end
    respond_to do |format|
      format.html
      format.json { render json: @user }
      format.js
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if user_params[:password].blank?
       user_params.delete(:password)
       user_params.delete(:password_confirmation) if user_params[:password_confirmation].blank?
     end

    respond_to do |format|
      ret = @user.update_without_password(user_params) if user_params[:password].blank?
      ret = @user.update(params[:user].permit(:email, :password, :password_confirmation, :height, :birth, :firstname, :lastname)) unless user_params[:password].blank?
      if ret
        sign_in(@user, :bypass => true)
        format.html { redirect_to edit_user_path(@user), notice: 'L\'utilisateur a bien été mis à jour.' }
        format.json { render json: { status: "OK", data: nil, message: nil } }
      else
        format.html { render action: 'edit', notice: 'L\'utilisateur n\'a pas pu être sauvegardé.' }
        format.json { render json:{ status: "KO", data: nil, message: @user.errors.message }, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:photo, :email, :id, :username, :firstname, :lastname, :password, :gender, :birth, :role, :lastConnexion, :loginAttempts, :lock, :islock, :resetToken, :highCholesterol, :highBloodPressure, :height, :weight, :desireWeight, :idealWeight, :home_id, :weightPointId, :dietTypeId, :weightCurveId, :current_password, :password_confirmation)
    end
end
