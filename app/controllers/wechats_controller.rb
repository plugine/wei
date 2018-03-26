

# frozen_string_literal: true

class WechatsController < ApplicationController
  include WechatService

  before_action :set_message, only: :create

  def show
    return (head :unauthorized) unless verify_signature
    render text: params[:echostr]
  end

  def create
    # TODO: 将所有消息用sidekiq异步存起来，用ssdb超时做消息MsgId排重
    return (head :unauthorized) unless verify_signature
    api = account_api @message[:ToUserName]
    api.custom_message_send @message.reply.text(@message[:Content])
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
end
