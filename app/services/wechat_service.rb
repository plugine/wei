class WechatService
  include Singleton
  # include ActiveSupport::Concern

  # 获取指定微信号的账号
  def account_api(account)
    build_api(account)
  end

  def name_api(name)
    account = PublicAccount.find_by_name(name.to_s)
    build_api(account)
  end

  def raw_api(account_attrs)
    options = account_attrs.symbolize_keys
    build_api_with_attr options[:appid], options[:appsecret], options[:id]
  end


  private

  def build_api(account)
    a = account
    Wechat::Api.new a.appid, a.appsecret, "#{Rails.root}/tmp/token_#{a.id}", 5, true, "#{Rails.root}/tmp/jsticket_#{a.id}"
  end

  def build_api_with_attr(appid, appsecret, account_id)
    Wechat::Api.new appid, appsecret, "#{Rails.root}/tmp/token_#{account_id}", 5, true, "#{Rails.root}/tmp/jsticket_#{account_id}"
  end
end