module OrdersHelper
  def load_order id
    @order = Order.find_order_id id
  end
end
