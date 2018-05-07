class WechatService
  include Singleton
  # include ActiveSupport::Concern

  # 获取指定微信号的账号
  def account_api(account)
    build_api(account)
  end

  def name_api(name)
    account = PublicAccount.fetch_by_name(name.to_s)
    build_api(account)
  end

  def raw_api(account_attrs)
    options = account_attrs.symbolize_keys
    build_api_with_attr options[:appid], options[:appsecret], options[:id]
  end

  def wechat_oauth2(scope, page_url, account, cookies, params, clazz, &block)
    api = account_api(account)



    oauth2_params = {
        appid: account.appid,
        redirect_uri: page_url,
        scope: scope,
        response_type: 'code',
        state: api.jsapi_ticket.oauth2_state
    }

    openid  = cookies.signed_or_encrypted[:we_openid]
    unionid = cookies.signed_or_encrypted[:we_unionid]
    we_token = cookies.signed_or_encrypted[:we_access_token]
    if openid.present?
      yield openid, { 'openid' => openid, 'unionid' => unionid, 'access_token' => we_token}
    elsif params[:code].present? && params[:state] == oauth2_params[:state]
      Rails.logger.info "code: #{params[:code]}"
      access_info = api.web_access_token(params[:code])
      cookies.signed_or_encrypted[:we_openid] = { value: access_info['openid'], expires: 1200.seconds.from_now }
      cookies.signed_or_encrypted[:we_unionid] = { value: access_info['unionid'], expires: 1200.seconds.from_now }
      cookies.signed_or_encrypted[:we_access_token] = { value: access_info['access_token'], expires: 1200.seconds.from_now }
      yield access_info['openid'], access_info
    else
      clazz.redirect_to generate_oauth2_url(oauth2_params)
    end
  end

  def jsapi_config(config_options={})
    options = config_options.symbolize_keys
    account = PublicAccount.fetch_by_name(options[:account])
    api = WechatService.instance.account_api account
    app_id = account.appid

    page_url = options[:page_url]

    js_hash = api.jsapi_ticket.signature(page_url)

    {
        debug: false,
        appId: app_id,
        timestamp: js_hash[:timestamp],
        nonceStr: js_hash[:noncestr],
        signature: js_hash[:signature],
        jsApiList: ['chooseWXPay']
    }
  end


  private

  def build_api(account)
    a = account
    Wechat::Api.new a.appid, a.appsecret, "#{Rails.root}/tmp/token_#{a.id}", 5, true, "#{Rails.root}/tmp/jsticket_#{a.id}"
  end

  def build_api_with_attr(appid, appsecret, account_id)
    Wechat::Api.new appid, appsecret, "#{Rails.root}/tmp/token_#{account_id}", 5, true, "#{Rails.root}/tmp/jsticket_#{account_id}"
  end

  def generate_oauth2_url(oauth2_params)
    if oauth2_params[:scope] == 'snsapi_login'
      "https://open.weixin.qq.com/connect/qrconnect?#{oauth2_params.to_query}#wechat_redirect"
    else
      "https://open.weixin.qq.com/connect/oauth2/authorize?#{oauth2_params.to_query}#wechat_redirect"
    end
  end
end