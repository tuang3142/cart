class OrdersController < ApplicationController
  include CurrentCart
  before_action :find_or_create_cart, only: [:new, :create]
  before_action :ensure_cart_isnt_empty, only: :new
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  def index
    @orders = Order.all
  end

  def show; end

  def new
    @order = Order.new
  end

  def edit; end

  def create
    @order = Order.new(order_params)
    @order.add_line_items_from_cart(@current_cart)

    respond_to do |format|
      if @order.save
        Cart.destroy(session[:cart_id])
        session[:cart_id] = nil
        format.html { redirect_to store_index_url, notice:
          'Thank you for your order.' }
        format.json { render :show, status: :created,
          location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors,
          status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @order.update(order_params)
        format.html { redirect_to @order, notice: 'Order was successfully updated.' }
        format.json { render :show, status: :ok, location: @order }
      else
        format.html { render :edit }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_order
    @order = Order.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def order_params
    params.require(:order).permit(:name, :address, :email, :payment_method)
  end

  def ensure_cart_isnt_empty
    if @current_cart.line_items.empty?
      redirect_to store_index_url, notice: 'Your cart is empty'
    end
  end

  # todo: make sure this is used
  def payment_method_params
    if order_params[:payment_method] == "Credit card"
      params.require(:order).permit(:credit_card_number, :expiration_date)
    elsif order_params[:payment_method] == "Check"
      params.require(:order).permit(:routing_number, :account_number)
    elsif order_params[:payment_method] == "Purchase order"
      params.require(:order).permit(:po_number)
    else
      {}
    end
  end
end
