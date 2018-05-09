class PaymentsController < ApplicationController
  def create
    order = Order.find(params[:order_id])
    payment = WxpubPaymentService.instance.pay params[:pay_config], params[:openid], order
    render json: {code: 200, payment: payment.to_api_json}
  end

  def wx_notify
    logger.info "params: #{params}"
    logger.info "transformed: #{params_transform}"
    render text: 'ok'
  end

  private

  def params_transform
    raw_data = request.body.read
    notify_params = HashWithIndifferentAccess.new(Hash.from_xml(raw_data)['xml'])
    payment = Payment.find_by payment_no: notify_params[:out_trade_no]
    notify_params[:key] =  WxpubPayConfig.find(payment.pay_res_id).key
    notify_params
  end
end