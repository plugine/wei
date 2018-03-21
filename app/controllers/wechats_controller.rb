class WechatsController < ApplicationController
  include WechatService

  before_action :set_message, only: :create

  def show
    return (head :unauthorized) unless verify_signature
    render text: params[:echostr]
  end

  def create
    return (head :unauthorized) unless verify_signature
    render xml: Wechat::Message.new({}).text(@message['Content'])
  end

  private

  def verify_signature
    params[:signature] == Wechat::Signature.hexdigest('je99znyl3b1sv499', params[:timestamp], params[:nonce], nil)
  end

  def set_message
    @message = Wechat::Message.from_hash Hash.from_xml(request.raw_post)
  end
end
