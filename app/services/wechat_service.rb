module WechatService
  # include ActiveSupport::Concern

  # 获取指定微信号的账号
  def account_api(account_name)
    # TODO 增加缓存支持
    account = PublicAccount.find_by_account(account_name.to_s)
    build_api(account)
  end

  def name_api(name)
    account = PublicAccount.find_by_name(name.to_s)
    build_api(account)
  end

  private

  def build_api(account)
    a = account
    Wechat::Api.new a.appid, a.appsecret, "#{Rails.root}/tmp/token_#{a.name}", 5, true, "#{Rails.root}/tmp/jsticket_#{a.name}"
  end

end