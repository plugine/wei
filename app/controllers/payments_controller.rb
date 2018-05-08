class PaymentsController < ApplicationController
  def create
    order = Order.find(params[:order_id])
    payment = WxpubPaymentService.instance.pay params[:pay_config], params[:openid], order
    render json: {code: 200, payment: payment.to_api_json}
  end

  def wx_notify
  end
end