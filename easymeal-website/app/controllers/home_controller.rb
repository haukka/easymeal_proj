class HomeController < ApplicationController
  before_filter :authenticate

  def index
    @weight_points = current_user.weight_points
    @errors = []
    respond_to do |format|
      format.html { render :index }
      format.json { render json: nil }
    end
  end

end
