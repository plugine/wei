class JoinActivityWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(option)
    option = option.symbolize_keys

    user = User.find(option[:user_id])
    account = PublicAccount.find(option[:account_id])
    api = WechatService.new.account_api account

    activity = "Activity#{option[:activity_id]}".constantize.new(
        Activity.find(option[:activity_id]),
        user, api, account, option[:message], join_result
    )
    activity.start
  end
end