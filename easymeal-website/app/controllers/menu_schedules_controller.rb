class MenuSchedulesController < ApplicationController
  before_action :set_menu_schedule, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :authorize

  # GET /menu_schedules
  # GET /menu_schedules.json
  def index
    @menu_schedules = MenuSchedule.all
  end

  # GET /menu_schedules/1
  # GET /menu_schedules/1.json
  def show
  end

  # GET /menu_schedules/new
  def new
    @menu_schedule = MenuSchedule.new
  end

  # GET /menu_schedules/1/edit
  def edit
  end

  # POST /menu_schedules
  # POST /menu_schedules.json
  def create
    @menu_schedule = MenuSchedule.new(menu_schedule_params)

    respond_to do |format|
      if @menu_schedule.save
        format.html { redirect_to @menu_schedule, notice: 'Menu schedule was successfully created.' }
        format.json { render action: 'show', status: :created, location: @menu_schedule }
      else
        format.html { render action: 'new' }
        format.json { render json: @menu_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /menu_schedules/1
  # PATCH/PUT /menu_schedules/1.json
  def update
    respond_to do |format|
      if @menu_schedule.update(menu_schedule_params)
        format.html { redirect_to @menu_schedule, notice: 'Menu schedule was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @menu_schedule.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /menu_schedules/1
  # DELETE /menu_schedules/1.json
  def destroy
    @menu_schedule.destroy
    respond_to do |format|
      format.html { redirect_to menu_schedules_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_menu_schedule
      @menu_schedule = MenuSchedule.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def menu_schedule_params
      params.require(:menu_schedule).permit(:weekNumber, :year, :home_id)
    end
end
