class DiseasesController < ApplicationController
  before_action :set_disease, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :authorize

  # GET /diseases
  # GET /diseases.json
  def index
    @diseases = Disease.all
  end

  # GET /diseases/1
  # GET /diseases/1.json
  def show
  end

  # GET /diseases/new
  def new
    @disease = Disease.new
  end

  # GET /diseases/1/edit
  def edit
  end

  # POST /diseases_user
  # POST /diseases_user.json
  def add_disease_to_user
    @user = current_user;
    @user.diseases << Disease.find_by_name(disease_params[:name])
    
    respond_to do |format|
      flash[:success] = 'disease was successfully add.' 
      format.html { redirect_to url_for(:controller => :diet_types, :action => :index) }
    end
  end

  # POST /diseases
  # POST /diseases.json
  def create
    @disease = Disease.new(disease_params)

    respond_to do |format|
      if @disease.save
        format.html { redirect_to @disease, notice: 'Disease was successfully created.' }
        format.json { render action: 'show', status: :created, location: @disease }
      else
        format.html { render action: 'new' }
        format.json { render json: @disease.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /diseases/1
  # PATCH/PUT /diseases/1.json
  def update
    respond_to do |format|
      if @disease.update(disease_params)
        format.html { redirect_to @disease, notice: 'Disease was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @disease.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /diseases/1
  # DELETE /diseases/1.json
  def destroy
    @user = current_user
    if !@user.nil?
      puts @user.lastname
      @user.diseases.delete(Disease.find(params[:id]))
    else
      @disease.destroy
    end

    respond_to do |format|
      flash[:success] = 'disease was successfully remove.' 
      format.html { redirect_to url_for(:controller => :diet_types, :action => :index) }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_disease
      @disease = Disease.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def disease_params
      params.require(:disease).permit(:name)
    end
end
