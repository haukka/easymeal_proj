class DietTypesController < ApplicationController
  before_action :set_diet_type, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :authorize

  # GET /diet_types
  # GET /diet_types.json

  def index
    @diet_types = DietType.all
    @diet_type = DietType.new
    @diseases = Disease.all
    @disease = Disease.new
    @user_disease = current_user.diseases
  end

  # GET /diet_types/1
  # GET /diet_types/1.json
  def show
  end

  # GET /diet_types/new
  def new
 #   if !diet_type
      @diet_type = DietType.new
 #   end
  end

  # GET /diet_types/1/edit
  def edit
  end

  # POST /diet_types_user
  # POST /diet_types_user.json
  def add_to_user
    @user = current_user;
    @user.diet_type = DietType.find_by_name(diet_type_params[:name])
    
    respond_to do |format|
      flash[:success] = 'diet type was successfully add.' 
      format.html { redirect_to action:"index" }
    end
  end

  # POST /diet_types
  # POST /diet_types.json
  def create
    @diet_type = DietType.new(diet_type_params)
    
    respond_to do |format|
      if @diet_type.save
        format.html { redirect_to @diet_type, notice: 'Diet type was successfully created.' }
        format.json { render action: 'show', status: :created, location: @diet_type }
      else
        format.html { render action: 'new' }
        format.json { render json: @diet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diet_types/1
  # PATCH/PUT /diet_types/1.json
  def update
    respond_to do |format|
      if @diet_type.update(diet_type_params)
        format.html { redirect_to @diet_type, notice: 'Diet type was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @diet_type.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diet_types/1
  # DELETE /diet_types/1.json
  def destroy
    @diet_type.destroy
    respond_to do |format|
      format.html { redirect_to diet_types_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_diet_type
      @diet_type = DietType.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def diet_type_params
      params.require(:diet_type).permit(:name)
    end
end
