class AlimentsController < ApplicationController
  before_action :set_aliment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :authorize

  # GET /aliments
  # GET /aliments.json
  def index
    @aliments = Aliment.all
  end

  # GET /aliments/1
  # GET /aliments/1.json
  def show
  end

  # GET /aliments/1/edit
  def edit
  end

  # PATCH/PUT /aliments/1
  # PATCH/PUT /aliments/1.json
  def update
    respond_to do |format|
      if @aliment.update(aliment_params)
        format.html { redirect_to @aliment, notice: 'Aliment was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @aliment.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_aliment
      @aliment = Aliment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def aliment_params
      params[:aliment]
    end
end
