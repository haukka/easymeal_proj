# -*- encoding : utf-8 -*-
class ShoppingListsController < ApplicationController
  before_action :set_shopping_list, only: [:show, :edit, :update, :destroy]
  before_filter :authenticate
  before_filter :authorize

  def alim_list_validate
    shopping_list = ShoppingList.find_by_id(params[:shopping_list][:list_id])
    stock = current_user.home.stocks.first
    if !stock.nil?
      shopping_list.aliments_quantity.each do |alim|
        verifalim = AlimentsQuantity.where("stock_id  = ? AND aliment_id = ?",stock.id, alim.aliment_id).take
        if !verifalim.nil?
          verifalim.quantity = verifalim.quantity + alim.quantity
          verifalim.save
        else
          AlimentsQuantity.create(aliment_id: alim.aliment_id, quantity: alim.quantity, stock_id: stock.id)
        end
      end
    end
    shopping_list.aliments_quantity.clear
    respond_to do |format|
      flash[:success] = 'aliments were add to the stock.'
      format.html { redirect_to :back, notice: 'Shopping list was successfully reinitialized.' }
    end
  end

  # GET /shopping_lists
  # GET /shopping_lists.json
  def index
    if !current_user.home.nil?
      @shopping_lists = current_user.home.shopping_lists
    end
    @shopping_list = ShoppingList.new
  end

  # GET /shopping_lists/1
  # GET /shopping_lists/1.json
  def show
    @shopping_lists = ShoppingList.all
    @shopping_list = ShoppingList.find(params[:id])
    @aliments = @shopping_list.aliments_quantity
    @id = @shopping_list.id
  end

  # GET /shopping_lists/new
  def new
    @shopping_list = ShoppingList.new
  end

  # GET /shopping_lists/1/edit
  def edit
    @aliments = @shopping_list.aliments
  end

  #POST /shopping_lists_alim
  #POST /shopping_lists_alim.json
  def associate_to_shopping_lists
    @aliment = Aliment.find_by_id(params[:shopping_list][:aliment_id])
    @quantity = params[:shopping_list][:quantity]
    if (@quantity.to_i > 0)
      @shopping_list_current = ShoppingList.find_by_id(params[:shopping_list][:list_id])
      @verifalim = AlimentsQuantity.where("shopping_list_id = ? AND aliment_id = ?", @shopping_list_current.id, @aliment.id).take
      if !@verifalim.nil?
        @verifalim.quantity = @verifalim.quantity + @quantity.to_i
        @verifalim.save
      else
        @shopping_list_current = AlimentsQuantity.create(aliment: @aliment, quantity: @quantity, shopping_list_id: @shopping_list_current.id)
      end
      respond_to do |format|
        flash[:success] = 'aliment was successfully add.'
        format.html { redirect_to :back, notice: 'aliment was successfully associated.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: 'aliment was not associated.' }
      end
    end
  end

  #POST /shopping_lists_alim_reinit
  #POST /shopping_lists_alim_reinit.json
  def reinit_shopping_lists
    @shopping_list_current = ShoppingList.find_by_id(params[:shopping_list][:list_id])
    if !@shopping_list_current.aliments_quantity.nil?
      @shopping_list_current.aliments_quantity.clear
      respond_to do |format|
        flash[:success] = 'aliments were successfully remove.'
         format.html { redirect_to :back, notice: 'Shopping list was successfully reinitialized.' }
      end
    end
  end

  #POST /shopping_lists_alim_remove
  #POST /shopping_lists_alim_remove.json
  def remove_alim_list
    @aliments_current = AlimentsQuantity.find_by_id(params[:alim_id])
    @aliments_current.destroy
    respond_to do |format|
      flash[:success] = 'aliments were successfully remove.'
      format.html { redirect_to :back}
    end
  end

  #POST /shopping_lists_alim_update
  #POST /shopping_lists_alim_update.json
  def alim_list_update
    @aliments_current = AlimentsQuantity.find_by_id(params[:shopping_list][:aliment_id])
    @val = params[:shopping_list][:quantity]
    if (@val.to_i > 0)
      @aliments_current.quantity = @val
    else
      @aliments_current.destroy
    end
    respond_to do |format|
      if @aliments_current.save
        flash[:success] = 'aliments were successfully updated.'
        format.html { redirect_to :back}
      end
    end
  end

  # POST /shopping_lists
  # POST /shopping_lists.json
  def create
    if !current_user.home.nil?
      respond_to do |format|
        if current_user.home.shopping_lists.count < 5 || current_user.home.shopping_lists.nil?
          @shopping_list = current_user.home.shopping_lists.new(shopping_list_params)
          # respond_to do |format|
            if @shopping_list.save
              format.html { redirect_to @shopping_list, notice: 'Shopping list was successfully created.' }
              format.json { render action: 'show', status: :created, location: @shopping_list }
            else
              format.html { render action: 'new' }
              format.json { render json: @shopping_list.errors, status: :unprocessable_entity }
            end
          # end
        else
          format.html { redirect_to shopping_lists_path, notice: 'Maximum reached' }
          format.json { render json: { status: "OK", result: nil, message: "Maximum reached" } }
        end
      end
    else
      redirect_to action: "index"
    end
  end

  # PATCH/PUT /shopping_lists/1
  # PATCH/PUT /shopping_lists/1.json
  def update
    respond_to do |format|
      if @shopping_list.update(shopping_list_params)
        format.html { redirect_to @shopping_list, notice: 'Shopping list was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @shopping_list.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /shopping_lists/1
  # DELETE /shopping_lists/1.json
  def destroy
    @shopping_list = ShoppingList.find(params[:id])
    if current_user.home.shopping_lists.count > 1
      @shopping_list.destroy
    end
    respond_to do |format|
      format.html { redirect_to shopping_lists_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_shopping_list
      @shopping_list = ShoppingList.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def shopping_list_params
      params.require(:shopping_list).permit(:name)
    end
end
