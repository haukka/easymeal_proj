# -*- encoding : utf-8 -*-
class RecipesController < ApplicationController
  before_action :set_recipe, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate, except: [ :autocomplete_aliment_name ]
  before_filter :authorize
  autocomplete :aliment, :name

  # GET /recipes
  # GET /recipes.json
  def index
    if params[:search]
      @recipes = Recipe.liked(current_user).find(:all, :conditions => ['name LIKE ?', "%#{params[:search]}%"])
    else
      @recipes = Recipe.liked(current_user)
    end
    recipes = []
    @recipes.each do |recipe|
      recipes << { name: recipe.name, id: recipe.id, photo_url: recipe.photo.url(:thumb) }
    end
    
    respond_to do |format|
      format.html { render action: 'index' }
      format.json { render json: { status: "OK", response: { recipes: recipes }, message: nil } }
    end
  end

  def aliments_quantity_attributes=(attributes)
    # Process the attributes hash
  end
  
  def recipes_select
    @recipe = Recipe.new
    @recipe.aliments_quantity.build
    @recipes = Recipe.liked(current_user).order_by_rand.limit(4)
    @recipe_test = Recipe.all
  end

  # GET /recipes/1
  # GET /recipes/1.json
  def show
      respond_to do |format|
        format.html { render action: 'show' }
        format.json { render json: { status: "OK", response: { recipe: @recipe }, message: nil } }
      end
  end

  # GET /recipes/new
  def new
    @recipe = Recipe.new
    @aliments = Aliment.all.collect{|a| a.name.html_safe }
  end

  # GET /recipes/1/edit
  def edit
  end

  # POST /recipes
  # POST /recipes.json
  def create
    respond_to do |format|
      if @recipe = Recipe.create(recipe_params)
          # load recipe category
          categories_array = params[:recipe][:recipe_categories]
          categories = []
          categories_array.each do |category|
            found = RecipeCategory.find(category.to_i) unless category.blank?
            categories << found if found
          end
          # load calories in recipe
        calories = 0
        @recipe.aliments_quantity.each do |alim|
          if alim.aliment && alim.quantity && alim.aliment.isQuantifiable
            calories += (alim.quantity / 100.0 * alim.aliment.calories)
          elsif alim.aliment && alim.quantity
            calories += (alim.quantity * alim.aliment.calories)
          end
        end
        
        # divide calories by the number of servings
        if params[:recipe][:nb_servings]
          calories = calories / params[:recipe][:nb_servings].to_i
        end
        # update the recipe
        @recipe.update(recipe_categories: categories, calories: calories)
        
        format.html { redirect_to recipes_select_path, notice: 'La recette a bien été crée. Un administrateur doit maintenant la valider.' }
        format.json { render json: { status: "OK", data: nil, message: "CREATE_SUCCESS" } }
      else
        format.html { render action: 'new' }
        format.json { render json: { status: "KO", data: nil, message: @recipe.errors.message } }
      end
    end
  end
  
  def pendingRecipes
    @count = Recipe.with_pending_state.count
    @entries = Recipe.entries.with_pending_state
    @desserts = Recipe.desserts.with_pending_state
    @dishes = Recipe.dishes.with_pending_state
    @collations = Recipe.collations.with_pending_state
    
    respond_to do |format|
      format.json { render json: { status: "OK", data: { count: @count, entries: @entries, desserts: @desserts, dishes: @dishes, collations: @collations }, message: nil } }
    end
  end

  # PATCH/PUT /recipes/1
  # PATCH/PUT /recipes/1.json
  def update
    respond_to do |format|
      if @recipe.update(recipe_params)
          # load recipe category
          categories_array = params[:recipe][:recipe_categories]
          categories = []
          categories_array.each do |category|
            found = RecipeCategory.find(category.to_i) unless category.blank?
            categories << found if found
          end
          # load calories in recipe
        calories = 0
        @recipe.aliments_quantity.each do |alim|
          if alim.aliment && alim.quantity && alim.aliment.isQuantifiable
            calories += (alim.quantity / 100.0 * alim.aliment.calories)
          elsif alim.aliment && alim.quantity
            calories += (alim.quantity * alim.aliment.calories)
          end
        end
        
        # divide calories by the number of servings
        if params[:recipe][:nb_servings]
          calories = calories / params[:recipe][:nb_servings].to_i
        end
        # update the recipe
        @recipe.update(recipe_categories: categories, calories: calories)
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
      params.require(:recipe).permit(:name, :difficulty, :time, :calories, :text, :price, :nb_servings, :photo, :recipe_categories, aliments_quantity_attributes: [:id, :aliment_id, :quantity, :_destroy])
    end
end
