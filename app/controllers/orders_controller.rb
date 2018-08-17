class OrdersController < ApplicationController
  def update
    @order = Order.find_by_id params[:id]
    @sum_total = OrderDetail.where(order_id: params[:id]).sum(:total_price)
    if current_user.role == "user"
      if @order.update_attributes status: :ordered, total_pice: @sum_total
        flash[:success] = t "order.message.ordered_success"
        redirect_to foods_url
      else
        flash[:danger] = t "order.message.ordered_failure"
        redirect_to order_details_url
      end
    end
  end
end
