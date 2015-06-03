class Admin::DashboardController < Admin::AdminController
  def index
    @entries = Recipe.entries.with_pending_state.limit(10)
    @dishes = Recipe.dishes.with_pending_state.limit(10)
    @desserts = Recipe.desserts.with_pending_state.limit(10)
    @collations = Recipe.collations.with_pending_state.limit(10)
  end
end