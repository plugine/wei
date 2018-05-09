class WxpubPayment < Payment

  def notify_url
    "#{APP_CONFIG['domain']}/payments/wx_notify"
  end

  module ::WxPay
    module Service
      def self.invoke_unifiedorder(params, options = {})
        params = {
            appid: options.delete(:appid) || WxPay.appid,
            mch_id: options.delete(:mch_id) || WxPay.mch_id,
            key: options.delete(:key) || WxPay.key,
            nonce_str: SecureRandom.uuid.tr('-', '')
        }.merge(params)

        check_required_options(params, INVOKE_UNIFIEDORDER_REQUIRED_FIELDS)

        hashed = invoke_remote("https://api.mch.weixin.qq.com/pay/unifiedorder", make_payload(params), options)
        puts "xml result: #{hashed}"
        r = WxPay::Result.new(Hash.from_xml(hashed))

        yield r if block_given?

        r
      end
    end
  end

  def fill_pay_data(openid, config_name)
    generate_payment_no

    content = {
        out_trade_no: payment_no,
        total_fee: (total_fee * 100).to_i,
        spbill_create_ip: '127.0.0.1',
        trade_type: 'JSAPI',
        body: order.title,
        notify_url: notify_url,
        openid: openid
    }

    pay_config = WxpubPayConfig.fetch config_name
    Rails.logger.info "contnet: #{content}, pay_config: #{pay_config.as_json}"
    result = WxPay::Service.invoke_unifiedorder content,
                                                pay_config.as_json.symbolize_keys
    Rails.logger.info "invoke result: #{result}"
    if result.success?
      js_pay_params = {
          prepayid: result['prepay_id'],
          noncestr: result['nonce_str'],
          key: pay_config.key
      }
      pay_params = WxPay::Service.generate_js_pay_req(
          js_pay_params,
          appid: pay_config.appid
      )

      self.pay_data = pay_params.to_json
      Rails.logger.info "pay_params: #{pay_params.to_json}"
    else
      Rails.logger.info result.to_s
    end
  end

  def generate_payment_no
    self.payment_no = "WXPUB-#{order.order_no}-#{Time.now.to_i.to_s[5, 10]}"
  end

  def to_api_json
    {
        id: id,
        order_id: order_id,
        pay_data: pay_data
    }
  end

  def self.generate(options={})
    openid = options.delete(:openid)
    cfg = options.delete :pay_config_name
    payment = self.new options
    payment.fill_pay_data(openid, cfg)

    payment
  end


end