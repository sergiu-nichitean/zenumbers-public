class AmazonOrdersController < ApplicationController
  before_action :set_amazon_order, only: [:show, :edit, :update, :destroy]

  # GET /amazon_orders
  # GET /amazon_orders.json
  def index
    @amazon_orders = AmazonOrder.all
  end

  # GET /amazon_orders/1
  # GET /amazon_orders/1.json
  def show
  end

  # GET /amazon_orders/new
  def new
    @amazon_order = AmazonOrder.new
  end

  # GET /amazon_orders/1/edit
  def edit
  end

  # POST /amazon_orders
  # POST /amazon_orders.json
  def create
    @amazon_order = AmazonOrder.new(amazon_order_params)

    respond_to do |format|
      if @amazon_order.save
        format.html { redirect_to @amazon_order, notice: 'Amazon order was successfully created.' }
        format.json { render :show, status: :created, location: @amazon_order }
      else
        format.html { render :new }
        format.json { render json: @amazon_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /amazon_orders/1
  # PATCH/PUT /amazon_orders/1.json
  def update
    respond_to do |format|
      if @amazon_order.update(amazon_order_params)
        format.html { redirect_to @amazon_order, notice: 'Amazon order was successfully updated.' }
        format.json { render :show, status: :ok, location: @amazon_order }
      else
        format.html { render :edit }
        format.json { render json: @amazon_order.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /amazon_orders/1
  # DELETE /amazon_orders/1.json
  def destroy
    @amazon_order.destroy
    respond_to do |format|
      format.html { redirect_to amazon_orders_url, notice: 'Amazon order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_amazon_order
      @amazon_order = AmazonOrder.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def amazon_order_params
      params.require(:amazon_order).permit(:amz_id, :purchase_date, :payments_date, :buyer_email, :buyer_name, :buyer_phone_number, :company_id)
    end
end
