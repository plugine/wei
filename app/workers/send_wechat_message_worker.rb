class SendWechatMessageWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(account_api, message)
    WechatService.new.raw_api account_api
    account_api.custom_message_send message.reply.text(content)
  end
end