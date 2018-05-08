class WxpubPaymentService
  include Singleton

  def pay(pay_config_name, openid, order)
    payment = Payment.generate pay_config_name: pay_config_name,
                               method: 'wxpub_payment',
                               total_fee: order.price + order.carriage,
                               order_id: order.id,
                               state: :initialized,
                               user_id: order.user_id,
                               openid: openid

    payment.save ? payment : nil
  end
end