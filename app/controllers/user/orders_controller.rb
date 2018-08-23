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
      content = t "notification.ordered_content"
      create_notification(params[:id], content)
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
      content = t "notification.received_content"
      update_notification(params[:order_id], content)
      flash[:success] = t "order.message.confirm_received_success"
      redirect_to user_orders_url
    else
      flash[:danger] = t "order.message.confirm_received_failure"
      redirect_to user_orders_url
    end
  end

  private

  def create_notification id, content
    OrderDetail.find_or_detail(id).each do |order_detail|
      @notification = Notification.new
      @notification.content = content
      @notification.restaurant_id = order_detail.restaurant_id
      @notification.order_id = params[:id]
      @notification.save
    end
  end

  def update_notification id, content
    OrderDetail.find_or_detail(id).each do |order_detail|
      restaurant_id = order_detail.restaurant_id
      @notification = Notification.find_by restaurant_id: restaurant_id
      @notification.update_attributes content: content
    end
  end
end
