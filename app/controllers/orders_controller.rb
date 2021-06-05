class OrdersController < ApplicationController

  def index
    @orders = Order.all
  end


  def show
    @order = Order.find(params[:customer_id])
  end

  def new
    customer = Customer.find(params[:customer_id])
    @order = Customer.Order.new
  end

  def create
    @order = Order.new(order_params)
    @order.save
    redirect_to @Order
  end

  def edit
    set_order
  end

  def update
    set_order
    @order.update(page_params)
    redirect_to @order
  end

  def destroy
    set_order
    @order.destroy
    redirect_to orders_path
  end

  private
  def order_params
    params.require(:order).permit(:customer_id, :product_name, :product_count)
    end



end
