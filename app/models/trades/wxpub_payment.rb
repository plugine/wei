class WxpubPayment < Payment

  def fill_pay_data

  end

  def to_api_json
    {
        id: id,
        order_id: order_id,
        pay_data: pay_data
    }
  end

  def self.generate(options)
    payment = self.new options
    payment.fill_pay_data
  end


end