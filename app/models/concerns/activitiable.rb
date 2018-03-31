module Activitiable
  extend ActiveSupport::Concern


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

  # 向当前用户发送
  def say(content)
    api.custom_message_send message.reply.text(content)
  end

  # 上游用户
  # alias_method :user_relaied, :relaied_user
  def relaied_user
    @relaied_user ||= get_relaied_user
  end

  # 发送文本消息给上游用户
  def say_to_relaied(content)
    api.custom_message_send Message.to(relaied_user.openid).text(content)
  end


  private

  def get_relaied_user
    user_id = @user.relied_user_id(@activity.id)
    user_id == 0 ? nil : User.find(user_id)
  end
end