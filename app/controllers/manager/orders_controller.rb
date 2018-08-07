class Manager::OrdersController < ApplicationController
  before_action :is_manager?

  def index
    @orders = Order.find_order_stt(:ordered).page(params[:page]).per Settings.rows
  end

  def all_orders
    @orders = Order.all_ordered_manager(:unordered).page(params[:page]).per Settings.rows
  end

  def update
    @order = Order.find_by_id params[:id]
    @sum_total = OrderDetail.find_or_detail(params[:id]).sum(:total_price)
    return if @order.nil?
    if @order.update_attributes status: :accepted, total_pice: @sum_total
      flash[:success] = t "order.message.ordered_success"
      redirect_to manager_orders_url
    else
      flash[:danger] = t "order.message.ordered_failure"
      redirect_to manager_orders_url
    end
  end

  def cancel_order
    @order = Order.find_by_id params[:order_id]
    if @order.update_attributes status: :cancel
      flash[:success] = t "order.message.cancel_success"
      redirect_to manager_orders_url
    else
      flash[:danger] = t "order.message.cancel_failure"
      redirect_to manager_orders_url
    end
  end
end
