class HomesController < ApplicationController
  before_action :set_home, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :authorize
  skip_before_filter :verify_authenticity_token

  # GET /homes
  # GET /homes.json
  def index
    @homes = Home.all

    respond_to do |format|
      format.html { render :index }
      format.json { render json: { "homes" => @homes } }
    end
  end

  # GET /homes/1
  # GET /homes/1.json
  def show
  end

  # GET /homes/new
  def new
    @home = Home.new
  end

  # GET /homes/1/edit
  def edit
  end
  
  # POST /homes/choose.json
  def choose
    @home = Home.find_by(id: params[:home][:id])
    puts "=========================================================="
    puts params.inspect
    @user = current_user

    respond_to do |format|
      if @user.update(home: @home)
        format.json { render json: { success: "Votre changement de foyer a été réalisé avec succès.", home: @home } }
      else
        format.json { render json: { error: "Une erreur est survenue." } }
      end
    end
  end

  # POST homes/search.json
  def search
    @homes = []
    @homes << Home.where(name: params[:home][:name])
    @homes << Home.where(street: params[:home][:street])
    @homes << Home.where(zipcode: params[:home][:zipcode])
    @homes << Home.where(city: params[:home][:city])
    
    @homes = @homes.flatten.uniq
    
    respond_to do |format|
      format.json { render json: @homes }
    end
  end

  # POST /homes
  # POST /homes.json
  def create
    @home = Home.new(home_params)
      @home.householder = current_user
      @home.users << current_user
    respond_to do |format|
      if @home.save
        format.html { redirect_to edit_user_path(current_user), notice: 'Home was successfully created.' }
        format.json { render json: { success: "Le foyer a été créé avec succès.", home: @home } }
      else
        format.html { render action: 'new' }
        format.json { render json: { error: @home.errors } }
      end
    end
  end

  # PATCH/PUT /homes/1
  # PATCH/PUT /homes/1.json
  def update
    respond_to do |format|
      if @home.update(home_params)
        format.html { redirect_to edit_user_path(current_user), notice: 'Home was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @home.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /homes/1
  # DELETE /homes/1.json
  def destroy
    @home.destroy
    respond_to do |format|
      format.html { redirect_to homes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_home
      @home = Home.find(params[:home][:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def home_params
      params.require(:home).permit(:street, :city, :householder, :zipcode, :name)
    end
end
