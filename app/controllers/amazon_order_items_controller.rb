class AmazonOrderItemsController < ApplicationController
  before_action :set_amazon_order_item, only: [:show, :edit, :update, :destroy]

  # GET /amazon_order_items
  # GET /amazon_order_items.json
  def index
    @amazon_order_items = AmazonOrderItem.all
  end

  # GET /amazon_order_items/1
  # GET /amazon_order_items/1.json
  def show
  end

  # GET /amazon_order_items/new
  def new
    @amazon_order_item = AmazonOrderItem.new
  end

  # GET /amazon_order_items/1/edit
  def edit
  end

  # POST /amazon_order_items
  # POST /amazon_order_items.json
  def create
    @amazon_order_item = AmazonOrderItem.new(amazon_order_item_params)

    respond_to do |format|
      if @amazon_order_item.save
        format.html { redirect_to @amazon_order_item, notice: 'Amazon order item was successfully created.' }
        format.json { render :show, status: :created, location: @amazon_order_item }
      else
        format.html { render :new }
        format.json { render json: @amazon_order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amazon_order_items/1
  # PATCH/PUT /amazon_order_items/1.json
  def update
    respond_to do |format|
      if @amazon_order_item.update(amazon_order_item_params)
        format.html { redirect_to @amazon_order_item, notice: 'Amazon order item was successfully updated.' }
        format.json { render :show, status: :ok, location: @amazon_order_item }
      else
        format.html { render :edit }
        format.json { render json: @amazon_order_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amazon_order_items/1
  # DELETE /amazon_order_items/1.json
  def destroy
    @amazon_order_item.destroy
    respond_to do |format|
      format.html { redirect_to amazon_order_items_url, notice: 'Amazon order item was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amazon_order_item
      @amazon_order_item = AmazonOrderItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amazon_order_item_params
      params.require(:amazon_order_item).permit(:amz_id, :sku, :product_name, :quantity_purchased, :currency, :item_price, :item_tax, :shipping_price, :shipping_tax, :amazon_orders_id)
    end
end
