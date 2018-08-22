module OrderDetailsHelper
  def find_order_detail id
    @order_detail = OrderDetail.find_by_id id
  end

  def find_order_detail_o_id od_id
    @order_detail = OrderDetail.where order_id: od_id
  end
end
