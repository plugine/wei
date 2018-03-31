

# frozen_string_literal: true

class WechatsController < ApplicationController

  before_action :set_message, only: :create

  def show
    return (head :unauthorized) unless verify_signature
    render text: params[:echostr]
  end

  # 微信消息入口
  def create
    return (head :unauthorized) unless verify_signature
    @account = PublicAccount.find_by_account @message[:ToUserName]

    @api = WechatService.instance.account_api @account

    logger.info request.body.read
    logger.info @message.to_json
    if @message[:MsgType] == 'event'
      # 事件消息
      event = @message[:Event]
      event_key = @message[:EventKey].gsub /qrscene_/, ''

      logger.info "event: #{@message[:MsgType]},  event_key: #{@message[:EventKey]}"

      if event == 'subscribe' || event == 'SCAN'
        if event_key.blank?
          # TODO 激活关注事件
        else
          # 活动事件处理
          handle_join_activity @message[:FromUserName], event_key
        end
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
    @message = Wechat::Message.from_hash(Hash.from_xml(request.raw_post)['xml'].symbolize_keys)
  end


  # base_#{activity_id}
  # acti_#{activity_id}_#{user_id}
  def handle_join_activity(openid, event_key)
    event_map = event_key.split '_'
    if event_map[0] == 'base'
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
    activity = "Activity#{activity_id}".constantize.new Activity.find(activity_id), user, @api, @account, @message, join_result
    activity.start
  end


end
