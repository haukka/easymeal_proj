# -*- encoding : utf-8 -*-
class RegistrationsController < Devise::RegistrationsController

  def create
    @user = User.new(user_params)
    @errors = []
    respond_to do |format|
      if @user.save
        format.html { redirect_to @user, notice: 'L\'utilisateur a bien été créé.' }
        format.json { render json: { status: "OK", data: { user: @user }, message: "USER_CREATED" } }
      else
        format.html { render action: 'new' }
        format.json { render json: { status: "KO", data: nil, message: @user.errors.message }, status: :unprocessable_entity }
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
      params.require(:user).permit(:photo, :email, :id, :username, :firstname, :lastname, :password, :gender, :birth, :mail, :role, :lastConnexion, :loginAttempts, :lock, :islock, :resetToken, :highCholesterol, :highBloodPressure, :height, :weight, :desireWeight, :idealWeight, :home_id, :weightPointId, :dietTypeId, :weightCurveId, :current_password, :password_confirmation)
    end
end