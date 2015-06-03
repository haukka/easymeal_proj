# -*- encoding : utf-8 -*-
class HomeController < ApplicationController
  before_filter :authenticate

  def index
    @user = current_user if current_user
    @weight_points = current_user.weight_points if current_user
    @weight = @weight_points.order('date DESC').first.weight if current_user && @weight_points.present?
    @IMC = (@weight / ((@user.height / 100.0) ** 2)).round(2) if current_user && @weight && @user.height
    
    client = YahooWeather::Client.new
    if current_user.nil? || current_user.home.nil?
      @city = "Paris"
      @response = client.fetch_by_location(@city)
    else
      @city = current_user.home.city
      @response = client.fetch_by_location(@city)
    end
    if @response
      @temperature = ((@response.condition.temp.to_i - 32)/1.8000).round
      @condition = @response.condition.code
    else
      @temperature = nil
      @condition = nil
    end
    
    @recipe_day = Recipe.where(recipe_day: true).take
    @recipe_day = Recipe.get_recipe_day unless @recipe_day

    @errors = []
    
    @aliments_quantity = current_user.home.shopping_lists.collect{|s| s.aliments_quantity }.flatten! if current_user && current_user.home
    
    respond_to do |format|
      format.html { render :index }
      format.json { render json: nil }
    end
  end

end
