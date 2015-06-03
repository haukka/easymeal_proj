class Admin::RecipesController < Admin::AdminController
  def index
    @entries = Recipe.entries.with_pending_state
    @desserts = Recipe.desserts.with_pending_state
    @dishes = Recipe.dishes.with_pending_state
    @collations = Recipe.collations.with_pending_state
  end
  
  def show
    @recipe = Recipe.find(params[:id])
  end
  
  def validate
    @recipe = Recipe.find(params[:id])
    @recipe.validate!
    redirect_to admin_recipes_path
  end
  
  def refuse
    @recipe = Recipe.find(params[:id])
    @recipe.refuse!
    redirect_to admin_recipes_path
  end
end