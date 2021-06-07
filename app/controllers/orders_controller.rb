class OrdersController < ApplicationController
    # before_action :set_customer
  rescue_from ActiveRecord::RecordNotFound, with: :catch_not_found
  before_action :set_order, only: [:show, :edit, :update, :destroy]


  def index
    @orders = Order.all
  end


  def show
    # @order = Order.find(params[:customer_id])
  end

  def edit
  end

  # def new
  #   customer = Customer.find(params[:customer_id])
  #   @order = Customer.Order.new
  # end
  def new
  @order = Order.new
  end


  # def create
  #   @order = @customer.orders.create(order_params)
  #   @order.save
  #   redirect_to @customer
  #
  # end

  def create
   @order = Order.new(order_params)
   if @order.save
     flash.notice = "The order record was created successfully."
     redirect_to @order
   else
     flash.now.alert = @order.errors.full_messages.to_sentence
     render :new
   end
 end



  # def edit
  #   set_order
  # end




  # def update
  #   set_order
  #   @order.update(page_params)
  #   redirect_to @order
  # end

  def update
  if @order.update(order_params)
    flash.notice = "The order record was updated successfully."
    redirect_to @order
  else
    flash.now.alert = @order.errors.full_messages.to_sentence
    render :edit
  end
end
  # def destroy
  #   set_order
  #   @order.destroy
  #   redirect_to orders_path
  # end

  def destroy
      @order.destroy
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
        format.json { head :no_content }
      end
    end

  def set_customer
   @customer = Customer.find(params[:customer_id])
 end

  private

  def set_order
   @order = Order.find(params[:id])
 end


  def order_params
    params.require(:order).permit(:customer_id, :product_name, :product_count)
    end

    def catch_not_found(e)
      Rails.logger.debug("We had a not found exception.")
      flash.alert = e.to_s
      redirect_to orders_path
    end
  end
