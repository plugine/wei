class WechatsController < ApplicationController

  before_action :set_message, only: :create

  def show
    return (head :unauthorized) unless verify_signature
    render text: params[:echostr]
  end

  # /wechat/auth/:storage_name
  def auth
    config = StorageService.instance.get(params[:storage_name])
    redirect_to :back, alert: '配置出错' unless config
    config = JSON.parse(config)
    logger.info "config: #{config}"
    account = PublicAccount.fetch_by_slug(config['account'])


    logger.info "account: #{account}"
    current_url = "#{config['domain']}/wechat/auth/#{params[:storage_name]}"

    WechatService.instance.wechat_oauth2('snsapi_userinfo', current_url, account, cookies, params, self) do |openid, access_info|
      logger.info "access info is: #{access_info.to_json}"
      user_info = WechatService.instance.account_api(account).web_userinfo access_info['access_token'], openid
      logger.info "EIP: wechat oauth user info: #{user_info.to_json}"
      first_matcher = config['redirect'].to_s.index('?') ? '&' : '?'
      redirect_url = "#{config['redirect']}#{first_matcher}openid=#{openid}&nickname=#{URI.escape user_info['nickname'].to_s}&headimgurl=#{user_info['headimgurl']}"
      redirect_to redirect_url
    end
  end

  # 根据传入的account生成JSAPI的config
  def wx_config
    render json: WechatService.instance.jsapi_config(account: params[:account], page_url: params[:page_url])
  end

  # 微信消息入口
  def create
    return (head :unauthorized) unless verify_signature
    @openid = @message[:FromUserName]

    @account = PublicAccount.fetch_by_name @message[:ToUserName]

    @api = WechatService.instance.account_api @account


    user = User.find_by_openid @openid
    user ||= User.create_from_hash(@account.id, @api.user(@openid))

    if @message[:MsgType] == 'event'
      # 事件消息
      event = @message[:Event]
      event_key = @message[:EventKey].gsub /qrscene_/, ''

      logger.info "event: #{@message[:Event]},  event_key: #{@message[:EventKey]}"

      if event == 'unsubscribe'
        # 取关
        user = User.find_by_openid @openid
        user.update alive: false, dead_at: DateTime.now if user
      end

      if event == 'subscribe' || event == 'SCAN'
        if event_key.blank?
          user.update alive: true if user
        else
          # 活动事件处理
          handle_join_activity @openid, event_key
        end
      end

      if event == 'CLICK'
        handle_join_activity @openid, event_key
      end

    end

    # 统一使用客服消息进行回复
    render text: ''
  end


  private

  def verify_signature
    token = 'je99znyl3b1sv499'
    timestamp = params[:timestamp]
    nonce = params[:nonce]
    array = [token, timestamp, nonce]
    dev_msg_signature = array.compact.collect(&:to_s).sort.join
    Digest::SHA1.hexdigest(dev_msg_signature) == params[:signature]
  end

  def set_message
    @message_text = request.raw_post
    @message = Wechat::Message.from_hash(Hash.from_xml(@message_text)['xml'].symbolize_keys)
  end


  # base_#{activity_id}
  # acti_#{activity_id}_#{user_id}
  def handle_join_activity(openid, event_key)
    event_map = event_key.split '_'
    if event_map[0] == 'base' || event_map[0] == 'btn'
      # 参加活动
      activity_id = event_map[1].to_i
      join_activity(openid, activity_id, @account.id, base: true)
    elsif event_map[0] == 'acti'
      # 接力
      activity_id = event_map[1].to_i
      base_user_id = event_map[2].to_i
      join_activity(openid, activity_id, @account.id, base: false, base_user_id: base_user_id)
    else
      # ignore
    end
  end


  def join_activity(openid, activity_id, account_id, base: true, base_user_id: 0)
    user = User.find_by_openid openid
    user ||= User.create_from_hash(account_id, @api.user(openid))

    join_result = user.join_activity(activity_id, base: base, base_user_id: base_user_id)
    logger.info "message_text: #{@message_text}"

    ActivityJoinWorker.perform_async activity_id, user.id, account_id, @message_text, join_result
  end


end
