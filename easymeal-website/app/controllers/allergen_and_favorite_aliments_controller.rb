# -*- encoding : utf-8 -*-
class AllergenAndFavoriteAlimentsController < ApplicationController
  before_action :set_allergen_and_favorite_aliment, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :authorize

  # GET /allergen_and_favorite_aliments
  # GET /allergen_and_favorite_aliments.json
  def index
    @allergen_and_favorite_aliments = AllergenAndFavoriteAliment.all
    @allergen_and_favorite_aliment = AllergenAndFavoriteAliment.new
    @allergen_aliment = current_user.allergen_and_favorite_aliments.where(:allergy => true)
    @favorite_aliment = current_user.allergen_and_favorite_aliments.where(:favori => true)
    @nfavorite_aliment = current_user.allergen_and_favorite_aliments.where(:favori => false)
  end

  # GET /allergen_and_favorite_aliments/1
  # GET /allergen_and_favorite_aliments/1.json
  def show
  end

  # GET /allergen_and_favorite_aliments/new
  def new
    @allergen_and_favorite_aliment = AllergenAndFavoriteAliment.new
  end

  # GET /allergen_and_favorite_aliments/1/edit
  def edit
  end

  # POST /allergen_and_favorite_aliments
  # POST /allergen_and_favorite_aliments.json
  def create
    @allergen_and_favorite_aliment = AllergenAndFavoriteAliment.new(allergen_and_favorite_aliment_params)
    @allergen_and_favorite_aliment.user_id = current_user.id
    respond_to do |format|
      if @allergen_and_favorite_aliment.save
        flash[:success] = 'Preference was successfully created.' 
        format.html { redirect_to action:"index" }
        format.json { render action: 'show', status: :created, location: @weight_point }
      else
        format.html { render action: 'new' }
        format.json { render json: @allergen_and_favorite_aliment.errors, status: :unprocessable_entity }
      end
    end
  end
  
  # PATCH/PUT /allergen_and_favorite_aliments/1
  # PATCH/PUT /allergen_and_favorite_aliments/1.json
  def update
    respond_to do |format|
      if @allergen_and_favorite_aliment.update(allergen_and_favorite_aliment_params)
        flash[:success] = 'Preference was successfully updated.' 
        format.html {redirect_to action:"index" }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @allergen_and_favorite_aliment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /allergen_and_favorite_aliments/1
  # DELETE /allergen_and_favorite_aliments/1.json
  def destroy
    @allergen_and_favorite_aliment.destroy
    respond_to do |format|
      format.html { redirect_to allergen_and_favorite_aliments_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_allergen_and_favorite_aliment
      @allergen_and_favorite_aliment = AllergenAndFavoriteAliment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def allergen_and_favorite_aliment_params
#      params[:allergen_and_favorite_aliment]
      params.require(:allergen_and_favorite_aliment).permit(:allergy, :favori, :aliment_id)
    end
end
