class OrdersController < ApplicationController
  def show
    @order = Order.find_by_order_no(params[:order_no])

    render json: {code: 200, order: @order.to_api_json}
  end

  def create
    @goods = Goods.find(params[:goods_id])
    @order = Order.generate_new order_params.merge(
        user_id: current_user.id,
        title: "#{@goods.title}-#{current_user.nickname}"
    )

    if @order.save
      render json: {code: 200, order: @order.to_api_json}
    else
      render json: {code: 419, error: (@order.errors.to_a.join '\n')}
    end
  end

  private

  def order_params
    params[:order].permit(:real_name, :phone, :address, :note)
  end
end