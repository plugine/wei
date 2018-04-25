module Activitiable
  extend ActiveSupport::Concern

  module ClassMethods
    def method_missing(name, *args, &block)
      define_method name , ->{self.instance_eval(%(%Q{#{args.first}})) }
    end
  end

  def user
    @user
  end

  def activity
    @activity
  end

  def account
    @account
  end

  def api
    @api
  end

  def message
    @message
  end

  def join_result
    @join_result
  end

  #--------------用户状态------------
  def join_success?
    @join_result == ErrorConst::JOIN_SUCCESS
  end

  def relay_self?
    @join_result == ErrorConst::USER_RELAY_SELF
  end

  def relaied?
    @join_result == ErrorConst::USER_RELAIED
  end

  def joined?
    @join_result == ErrorConst::JOINED
  end

  # 向当前用户发送文字
  def say(content)
    api.custom_message_send message.reply.text(content)
  end

  # 向当前用户发送图片
  def image(media_id)
    api.custom_message_send message.reply.image(media_id) if media_id.present?
  end

  # 上游用户
  # alias_method :user_relaied, :relaied_user
  def relaied_user
    @relaied_user ||= get_relaied_user
  end

  # 上游用户接力人列表
  def relaied_user_supporters
    relaied_user.supporters(activity.id)
  end

  # 发送文本消息给上游用户
  def say_to_relaied(content)
    Rails.logger.info "begin send relaied message from say_to_relaied"
    message = ::Wechat::Message.to(relaied_user.openid).text(content)
    Rails.logger.info "begin send relaied message from say_to_relaied1: #{message.to_json}"
    api.custom_message_send message
  end

  def en(str)
    Base64.urlsafe_encode64(str)
  end

  def invite_pic(background, querys)
    query = "watermark/3#{querys.join}"
    image_url = "#{background}?#{query}"
    Rails.logger.info "generate image result: #{image_url}"
    image_path = "#{Rails.root}/public/upload/invite_#{activity.id}_#{user.id}.png"
    File.open(image_path, 'wb') {|f| f.write HTTParty.get(image_url).body }
    media_id = (api.media_create 'image', image_path)['media_id']
    Rails.logger.info "generated media id: #{media_id}"
    media_id
  end

  # gravity:

  # NorthWest     |     North      |     NorthEast
  #               |                |
  #               |                |
  # --------------+----------------+--------------
  #               |                |
  # West          |     Center     |          East
  #               |                |
  # --------------+----------------+--------------
  #               |                |
  #               |                |
  # SouthWest     |     South      |     SouthEast
  def image_query(url, dissolve, gravity, dx, dy, ws)
    "/image/#{en url}/dissolve/#{dissolve}/gravity/#{gravity}/dx/#{dx}/dy/#{dy}/ws/#{ws}"
  end

  def qr_url
    ticket = (api.qrcode_create_scene "acti_#{activity.id}_#{user.id}")['ticket']
    "#{Activity::TICKET_BASE}#{ticket}"
  end


  private

  def get_relaied_user
    user_id = user.realied_user_id(activity.id)
    user_id == 0 ? nil : User.find(user_id)
  end
end