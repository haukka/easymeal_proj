class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :authorize

  # GET /recipes
  # GET /recipes.json
  def index
    if params[:search]
      @recipes = Recipe.find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    else
      @recipes = Recipe.all
    end
  end

  def aliments_quantity_attributes=(attributes)
    # Process the attributes hash
  end
  
  def recipes_select
    @recipe = Recipe.new
    @recipe.aliments_quantity.build
    @rand_id = rand(Recipe.count)
    if @rand_id < 1
      @rand_id = 1
    end
    @rand_id2 = rand(Recipe.count)
    if @rand_id2 < 1
      @rand_id2 = 1
    end
    @rand_id3 = rand(Recipe.count)
    if @rand_id3 < 1
      @rand_id3 = 1
    end
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    @recipe = Recipe.new(recipe_params)

    respond_to do |format|
      if @recipe.save
        format.html { redirect_to @recipe, notice: 'Recipe was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recipe }
      else
        format.html { render action: 'new' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
        format.html { redirect_to @recipe, notice: 'Recipe was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recipe.errors, status: :unprocessable_entity }
      end
    end
  end
  # DELETE /recipes/1.json
  def destroy
    @recipe.destroy
    respond_to do |format|
      format.html { redirect_to recipes_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe
      @recipe = Recipe.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_params
      params.require(:recipe).permit(:name, :difficulty, :time, :calories, :text, :price, aliments_quantity_attributes: [:id, :quantity])
    end
end
