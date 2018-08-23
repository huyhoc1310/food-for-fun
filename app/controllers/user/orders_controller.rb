class User::OrdersController < ApplicationController
  before_action :logged_in_user
  before_action :is_user?

  def index
    @orders = Order.find_order(current_user.id).page(params[:page]).per Settings.rows
  end

  def update
    @order = Order.find_by_id params[:id]
    @sum_total = OrderDetail.find_or_detail(params[:id]).sum(:total_price)
    return if @order.nil?
    if @order.update_attributes status: :ordered, total_pice: @sum_total
      flash[:success] = t "order.message.ordered_success"
      redirect_to foods_url
    else
      flash[:danger] = t "order.message.ordered_failure"
      redirect_to order_details_url
    end
  end

  def confirm_receive
    @order = Order.find_by_id params[:order_id]
    if @order.update_attributes status: :received
      flash[:success] = t "order.message.confirm_received_success"
      redirect_to user_orders_url
    else
      flash[:danger] = t "order.message.confirm_received_failure"
      redirect_to user_orders_url
    end
  end
end
