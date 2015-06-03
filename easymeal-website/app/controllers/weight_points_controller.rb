# -*- encoding : utf-8 -*-
class WeightPointsController < ApplicationController
  before_action :set_weight_point, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :authorize

  # GET /weight_points
  # GET /weight_points.json
  def index
    @weight_points = current_user.weight_points
    @weight_point = WeightPoint.new
  end

  # GET /weight_points/1
  # GET /weight_points/1.json
  def show
  end

  # GET /weight_points/new
  def new
    @weight_point = WeightPoint.new
  end

  # POST /weight_points
  # POST /weight_points.json
  def create
    @weight_point = WeightPoint.new(weight: params[:weight_point][:weight], date: Date.strptime(params[:weight_point][:date], "%m/%d/%Y"))
    @weight_point.user_id = current_user.id

    respond_to do |format|
      if @weight_point.save
        flash[:success] = 'Weight point was successfully created.' 
        format.html { redirect_to action:"index" }
        format.json { render action: 'show', status: :created, location: @weight_point }
      else
        format.html { render action: 'new' }
        format.json { render json: @weight_point.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weight_point
      @weight_point = WeightPoint.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weight_point_params
      params.require(:weight_point).permit(:user_id, :weight, :date)
    end
end
