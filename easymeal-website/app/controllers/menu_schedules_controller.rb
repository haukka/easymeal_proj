# -*- encoding : utf-8 -*-
class MenuSchedulesController < ApplicationController
  before_filter :authenticate
  before_filter :authorize

def planning_generation
  @today = Date.today
  if params[:data][:date]
    @week_begining = Date.parse(params[:data][:date]).beginning_of_week
  else
    @week_begining = @today.beginning_of_week
  end
  @week_end = @week_begining.end_of_week
  recipe = Recipe::Recipe.liked(current_user)
  starter = RecipeCategory.find(1).recipes.find_all_by_id(recipe)
  meal = RecipeCategory.find(2).recipes.find_all_by_id(recipe)
  dessert = RecipeCategory.find(3).recipes.find_all_by_id(recipe)
  starter = starter.delete_if { |recipe| recipe.calories == nil }
  meal = meal.delete_if { |recipe| recipe.calories == nil}
  dessert = dessert.delete_if { |recipe| recipe.calories == nil }
  if current_user.diet_type.name == "Hypocalorique"
    starter = starter.delete_if { |recipe| recipe.calories > 200 }
    meal = meal.delete_if { |recipe| recipe.calories > 200}
    dessert = dessert.delete_if { |recipe| recipe.calories > 200}
  elsif current_user.diet_type.name == "Stabilisation"
    if current_user.gender == "male"
      starterone = starter.delete_if { |recipe| recipe.calories > 333}
      starter = starterone.delete_if { |recipe| recipe.calories < 262}
      mealone = meal.delete_if { |recipe| recipe.calories > 333}
      meal = mealone.delete_if { |recipe| recipe.calories < 262}
      dessertone = dessert.delete_if { |recipe| recipe.calories > 333}
      dessert = dessertone.delete_if { |recipe| recipe.calories < 262}
    else
      starterone = starter.delete_if { |recipe| recipe.calories < 200}
      starter = starterone.delete_if { |recipe| recipe.calories > 250}
      mealone = meal.delete_if { |recipe| recipe.calories < 200}
      meal = mealone.delete_if { |recipe| recipe.calories > 250}
      dessertone = dessert.delete_if { |recipe| recipe.calories < 200}
      dessert = dessertone.delete_if { |recipe| recipe.calories > 250}
    end
  elsif current_user.diet_type.name == "Hypercalorique"
    starter = starter.delete_if { |recipe| recipe.calories < 333}
    meal = meal.delete_if { |recipe| recipe.calories < 333}
    dessert = dessert.delete_if { |recipe| recipe.calories < 333}
  end
  @user = User.find(current_user)
  compare_date = Date.yesterday
  for date in @week_begining..@week_end
    if date > compare_date
      for i in 1..2
        plannings = current_user.menu_schedules.where(date: date, meal: i)
        @recipe = []
        starter_sample = starter.sample
        meal_sample = meal.sample
        dessert_sample = dessert.sample
        if !starter.sample.nil?
          @recipe.push(starter_sample)
        end
        if !meal_sample.nil?
          @recipe.push(meal_sample)
        end
        if !dessert_sample.nil?
          @recipe.push(dessert_sample)
        end
        take = plannings.take
        if !take.nil?
          count = take.recipes.count
        else
          count = 0
        end
        if count == 0
          if @recipe.count != 0
            if plannings.count == 0
              if !@recipe[0].nil?
                @menu_schedule = MenuSchedule.create(users: [@user], recipes: [@recipe[0]], meal: i, date: date)
                for j in 1..2
                  if !@recipe[j].nil?
                    @menu_schedule.recipes << @recipe[j]
                  end
                end
              end
            else
              @menu_schedule = plannings.first
              for j in 0..2
                if !@recipe[j].nil?
                  @menu_schedule.recipes << @recipe[j]
                end
              end
           end
          end
          if !current_user.home.nil?
            if current_user.home.shopping_lists.count != 0
              @shopping_list = current_user.home.shopping_lists.first
              @stock = current_user.home.stocks.first
              if @recipe.count != 0
                for i in 0..2
                  if !@recipe[i].nil?
                    @recipe[i].aliments_quantity.each do |recipe|
                      @verifalim = AlimentsQuantity.where("shopping_list_id = ? AND aliment_id = ?", @shopping_list.id, recipe.aliment_id).take
                      @verifstock = AlimentsQuantity.where("stock_id = ? AND aliment_id = ?", @stock.id, recipe.aliment_id).take
                      if !@verifalim.nil?
                        if !@verifstock.nil?
                          date_meal = Date.yesterday
                          count = current_user.menu_schedules.joins(:recipes).where('recipes.id = ? AND date > ?', @recipe[i].id, date_meal).count
                          if (@verifalim.quantity + (recipe.quantity*count)) < @verifstock.quantity
                            @verifalim.quantity = @verifalim.quantity + (recipe.quantity - @verifstock.quantity)
                            if @verifalim.quantity > 0
                              @verifalim.save
                            else
                              @verifalim.destroy
                            end
                          else
                            @verifalim.quantity = @verifalim.quantity + recipe.quantity
                            @verifalim.save
                          end
                        else
                          @verifalim.quantity = @verifalim.quantity + recipe.quantity
                          @verifalim.save
                        end
                      else
                        date_meal = Date.yesterday
                        count = current_user.menu_schedules.joins(:recipes).where('recipes.id = ? AND date > ?', @recipe[i].id, date_meal).count
                        if !@verifstock.nil?
                          quantity = recipe.quantity
                          if count > 0
                            quantity = (quantity * count) - @verifstock.quantity
                          else
                            quantity = quantity - @verifstock.quantity
                          end
                          if quantity > 0
                            AlimentsQuantity.create(aliment_id: recipe.aliment_id, quantity: quantity, shopping_list_id: @shopping_list.id)
                          end
                        else
                          AlimentsQuantity.create(aliment_id: recipe.aliment_id, quantity: recipe.quantity, shopping_list_id: @shopping_list.id)
                        end
                      end
                    end
                  end
                end
              end
            end
          end
        end
      end
    end
end
  respond_to do |format|
    format.html { redirect_to :back }
  end
end

 def index
   @user_token = current_user.auth_token.to_s
   @today = Date.today
   if params[:date]
     @week_begining = Date.parse(params[:date]).beginning_of_week
   else
     @week_begining = @today.beginning_of_week
   end
   dates = []
   @week_end = @week_begining.end_of_week
   for date in @week_begining..@week_end
     dates << date
   end

   breakfasts = MenuSchedule.where(date: dates, meal: MenuSchedule::MEALS::Breakfast)
   lunchs = MenuSchedule.where(date: dates, meal: MenuSchedule::MEALS::Lunch)
   dinners = MenuSchedule.where(date: dates, meal: MenuSchedule::MEALS::Dinner)

   @breakfasts = []
   breakfasts.each do |b|
     @breakfasts << b if b.users.include? current_user
   end
   @breakfasts.group_by{|b| b.date}

   @lunchs = []
   lunchs.each do |l|
     @lunchs << l if l.users.include? current_user
   end
   @lunchs.group_by{|l| l.date}

   @dinners = []
   dinners.each do |d|
     @dinners << d if d.users.include? current_user
   end
   @dinners.group_by{|d| d.date}
   
   respond_to do |format|
     format.html { render 'index' }
     format.json { render json: { status: "OK", data: { breakfasts: @breakfasts, lunchs: @lunchs, dinners: @dinners }, message: nil } }
   end
 end
  
  def associate
    @user = User.find(params[:user]) if params[:user]
    @recipe = Recipe.find(params[:recipe]) if params[:recipe]
    @meal = params[:meal]
    @date = params[:date]

    plannings = current_user.menu_schedules.where(date: @date, meal: @meal)
    respond_to do |format|
      if plannings.count == 0
        @menu_schedule = MenuSchedule.create(users: [@user], recipes: [@recipe], meal: @meal, date: @date)
        if @menu_schedule
          format.json { render json: { status: "OK", data: { recipe_name: @recipe.name, recipe_id: @recipe.id }, message: t("alert.planning.associate_recipe_success") } }
        else
          format.json { render json: { status: "KO", data: { menu_schedule: @menu_schedule }, message: @menu_schedule.errors.message } }
        end
      else
        @menu_schedule = plannings.first
        @menu_schedule.recipes << @recipe
        if !current_user.home.nil?
          if current_user.home.shopping_lists.count != 0
            @shopping_list = current_user.home.shopping_lists.first
            @stock = current_user.home.stocks.first
            @begin = Date.parse(@date).beginning_of_week
            @end =  Date.parse(@date).end_of_week
            if !@recipe.nil?
              @recipe.aliments_quantity.each do |recipe|
                @verifalim = AlimentsQuantity.where("shopping_list_id = ? AND aliment_id = ?", @shopping_list.id, recipe.aliment_id).take
                @verifstock = AlimentsQuantity.where("stock_id = ? AND aliment_id = ?", @stock.id, recipe.aliment_id).take
                ident = @recipe.id
                if !@verifalim.nil?
                  if !@verifstock.nil?
                    date_meal = Date.yesterday
                    count = current_user.menu_schedules.joins(:recipes).where('recipes.id = ? AND date > ?', ident, date_meal).count
                    if (@verifalim.quantity + (recipe.quantity*count)) < @verifstock.quantity
                      @verifalim.quantity = @verifalim.quantity + (recipe.quantity - @verifstock.quantity)
                      if @verifalim.quantity > 0
                        @verifalim.save
                      else
                        @verifalim.destroy
                      end
                    else
                      @verifalim.quantity = @verifalim.quantity + recipe.quantity
                      @verifalim.save
                    end
                  else
                    @verifalim.quantity = @verifalim.quantity + recipe.quantity
                    @verifalim.save
                  end
                else
                  if !@verifstock.nil?
                    date_meal = Date.yesterday
                    count = current_user.menu_schedules.joins(:recipes).where('recipes.id = ? AND date > ?', ident, date_meal).count
                    if count > 0
                      quantity = (recipe.quantity * count) - @verifstock.quantity
                    else
                      quantity = recipe.quantity - @verifstock.quantity
                    end
                    if quantity > 0
                      AlimentsQuantity.create(aliment_id: recipe.aliment_id, quantity: quantity, shopping_list_id: @shopping_list.id)
                    end
                  else
                    AlimentsQuantity.create(aliment_id: recipe.aliment_id, quantity: recipe.quantity, shopping_list_id: @shopping_list.id)
                  end
                end
              end
            end
          end
        end
        if @menu_schedule.save
          format.json { render json: { status: "OK", data: { recipe_name: @recipe.name, recipe_id: @recipe.id }, message: t("alert.planning.associate_recipe_success") } }
        else
          format.json { render json: { status: "KO", data: @menu_schedule, message: @menu_schedule.errors.message } }
        end
      end
    end
  end
  
  def dissociate
    @user = User.find(params[:user]) if params[:user]
    @recipe = Recipe.find(params[:recipe]) if params[:recipe]
    @meal = params[:meal]
    @date = params[:date]
    plannings = current_user.menu_schedules.where(date: @date, meal: @meal)
    respond_to do |format|
      if plannings.count == 0
        format.json { render json: { status: "KO", response: @menu_schedule, message: t("alert.planning.dissociate_error") } }
      else
        if !current_user.home.nil?
          if current_user.home.shopping_lists.count != 0
            @shopping_list = current_user.home.shopping_lists.first
            @recipe.aliments_quantity.each do |recipe|
              @verifalim = AlimentsQuantity.where("shopping_list_id = ? AND aliment_id = ?", @shopping_list.id, recipe.aliment_id).take
              if !@verifalim.nil?
                @verifalim.quantity = @verifalim.quantity - recipe.quantity
                if @verifalim.quantity > 0
                  @verifalim.save
                else
                  @verifalim.destroy
                end
              end
            end
          end
        end
        plannings.each do |planning|
          if planning.recipes.delete(@recipe)
            format.json { render json: { status: "OK", response: @menu_schedule, message: t("alert.planning.dissociate_success") } }
          else
            format.json { render json: { status: "KO", response: @menu_schedule, message: t("alert.planning.dissociate_error") } }
          end
        end
      end
    end
  end
end
