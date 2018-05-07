class OrdersController < ApplicationController
  def show
    @order = Order.find_by_order_no(params[:order_no])

    render json: {code: 200, order: @order.to_api_json}
  end
end