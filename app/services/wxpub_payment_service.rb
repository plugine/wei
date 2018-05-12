class WxpubPaymentService
  include Singleton

  def pay(pay_config_name, openid, order)
    user = User.find_by_openid openid
    payment = Payment.generate pay_config_name: pay_config_name,
                               method: 'wxpub_payment',
                               total_fee: order.price + order.carriage,
                               order_id: order.id,
                               state: :initialized,
                               openid: openid,
                               user_id: user.id

    payment.save ? payment : nil
  end
end