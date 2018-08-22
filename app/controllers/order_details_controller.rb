class OrderDetailsController < ApplicationController
  def index
    @order_details = OrderDetail.list_order_details current_user.id
  end

  def create
    @order_detail = OrderDetail.find_order_detail(order_detail_params[:food_id], current_user.id).first
    if @order_detail.nil?
      @order = current_order
      if current_order.nil? || current_order.user_id != current_user.id
        init
      elsif current_order.ordered? || current_order.received? || current_order.accepted?
        init
      else
        @order = current_order
        @order_detail = @order.order_details.new order_detail_params
      end
      check_save @order
    else
      @order = Order.find_by_id @order_detail.order_id
      @order_detail.quantity += order_detail_params[:quantity].to_i
      check_save @order_detail
    end
    session[:order_id] = @order.id
  end

  def destroy
    @order_detail = OrderDetail.find_by_id params[:id]
    if @order_detail.destroy
      redirect_to order_details_url
    else
      redirect_to root_url
    end
  end
  private

  def order_detail_params
    params.require(:order_detail).permit :id, :quantity, :price, :total_price,
     :food_id, :order_id, :restaurant_id
  end

  def init
    @order = Order.new
    @order.user_id = current_user.id
    @order_detail = @order.order_details.new order_detail_params
  end

  def check_save ob
    if ob.save
      redirect_to foods_url
    else
      redirect_to root_url
    end
  end
end
