class RecipeCategoriesController < ApplicationController
  before_action :set_recipe_category, only: [:show, :edit, :update, :destroy]

  # GET /recipe_categories
  # GET /recipe_categories.json
  def index
    @recipe_categories = RecipeCategory.all
  end

  # GET /recipe_categories/1
  # GET /recipe_categories/1.json
  def show
  end

  # GET /recipe_categories/new
  def new
    @recipe_category = RecipeCategory.new
  end

  # GET /recipe_categories/1/edit
  def edit
  end

  # POST /recipe_categories
  # POST /recipe_categories.json
  def create
    @recipe_category = RecipeCategory.new(recipe_category_params)

    respond_to do |format|
      if @recipe_category.save
        format.html { redirect_to @recipe_category, notice: 'Recipe category was successfully created.' }
        format.json { render action: 'show', status: :created, location: @recipe_category }
      else
        format.html { render action: 'new' }
        format.json { render json: @recipe_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /recipe_categories/1
  # PATCH/PUT /recipe_categories/1.json
  def update
    respond_to do |format|
      if @recipe_category.update(recipe_category_params)
        format.html { redirect_to @recipe_category, notice: 'Recipe category was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @recipe_category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /recipe_categories/1
  # DELETE /recipe_categories/1.json
  def destroy
    @recipe_category.destroy
    respond_to do |format|
      format.html { redirect_to recipe_categories_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_recipe_category
      @recipe_category = RecipeCategory.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def recipe_category_params
      params[:recipe_category]
    end
end
