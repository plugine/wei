class PaymentsController < ApplicationController
  def create
    order = Order.find(params[:order_id])
    payment = Payment.generate({
        order_id: order.id,
        state: :initialized,
        user_id: order.user_id})
    render json: {code: 200, payment: payment.to_api_json}
  end

  def wx_notify
  end
end