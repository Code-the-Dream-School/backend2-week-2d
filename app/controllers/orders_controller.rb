class OrdersController < ApplicationController
    before_action :set_customer

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

  # def edit
  #   set_order
  # end

  def edit
  @order = Order.find(params[:customer_id])
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

  def set_customer
   @customer = Customer.find(params[:customer_id])
 end

  private
  def order_params
    params.require(:order).permit(:customer_id, :product_name, :product_count)
    end



end
