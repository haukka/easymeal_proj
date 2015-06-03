# -*- encoding : utf-8 -*-
class StocksController < ApplicationController
  before_action :set_stock, only: [:show, :edit, :update, :destroy]

  # GET /stocks
  # GET /stocks.json
  def index
    respond_to do |format|
      if !current_user.home.nil?
        @stocks = current_user.home.stocks
        format.html { render 'index' }
        format.html { render json: { status: "KO", data: nil, message: "You don't have any home" } }
      end
      @stock = Stock.new
      format.html { render 'index' }
      format.html { render json: { status: "OK", data: { stocks: @stocks }, message: nil } }
    end
  end

  # GET /stocks/1
  # GET /stocks/1.json
  def show
    @stocks = Stock.all
    @stock = Stock.find(params[:id]) if params[:id]
    @aliments = @stock.aliments_quantity
    @id = @stock.id
  end

  # GET /stocks/new
  def new
    @stock = Stock.new
  end

  # GET /stocks/1/edit
  def edit
  end

  #POST /stock_alim
  #POST /stock_alim.json
  def associate_to_stock
    @aliment = Aliment.find_by_id(params[:stock][:aliment_id])
    @quantity = params[:stock][:quantity]
    if (@quantity.to_i > 0)
      @stock_current = Stock.find_by_id(params[:stock][:list_id])
       @verifalim = AlimentsQuantity.where("stock_id = ? AND aliment_id = ?", @stock_current.id, @aliment.id).take
      if !@verifalim.nil?
        @verifalim.quantity = @verifalim.quantity + @quantity.to_i
        @verifalim.save
      else
        @stock_current = AlimentsQuantity.create(aliment: @aliment, quantity: @quantity, stock_id: @stock_current.id)
      end
      respond_to do |format|
        flash[:success] = 'aliment was successfully add.'
        format.html { redirect_to :back, notice: 'stock was successfully created.' }
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: 'stock was not created.' }
      end
    end
  end

  #POST /stock_reinit
  #POST /stock_reinit.json
  def reinit_stock
    @stock_current = Stock.find_by_id(params[:stock][:list_id])
    if !@stock_current.aliments_quantity.nil?
      @stock_current.aliments_quantity.clear
      respond_to do |format|
        flash[:success] = 'aliments were successfully remove.'
        format.html { redirect_to :back, notice: 'stock was successfully created.' }
      end
    end
  end

  #POST /stock_alim_remove
  #POST /stock_alim_remove.json
  def remove_alim_stock
    @aliments_current = AlimentsQuantity.find_by_id(params[:alim_id])
    @aliments_current.destroy
    respond_to do |format|
      flash[:success] = 'aliments were successfully remove.'
      format.html { redirect_to :back}
    end
  end

  #POST /stock_alim_update
  #POST /stock_alim_update.json
  def stock_alim_update
    @aliments_current = AlimentsQuantity.find_by_id(params[:stock][:aliment_id])
    @val = params[:stock][:quantity]
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

  # POST /stocks
  # POST /stocks.json
  def create
    @id = current_user.home.id
    @stock = Stock.new(stock_params)
    @stock.home_id = @id

    respond_to do |format|
      if @stock.save
        format.html { redirect_to :back }
        format.json { render json: { status: "OK", data: nil, message: nil } }
      else
        format.html { redirect_to 'new' }
        format.json { render json: { status: "KO", data: nil, message: @stock.errors.message }, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /stocks/1
  # PATCH/PUT /stocks/1.json
  def update
    respond_to do |format|
      if @stock.update(stock_params)
        format.html { redirect_to @stock, notice: 'Stock was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @stock.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /stocks/1
  # DELETE /stocks/1.json
  def destroy
    if current_user.home.stocks.count > 1
       @stock.destroy
     end
    respond_to do |format|
      format.html { redirect_to stocks_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stock
      @stock = Stock.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def stock_params
      params.require(:stock).permit(:name)
    end
end
