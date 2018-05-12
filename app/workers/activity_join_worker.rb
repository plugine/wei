class ActivityJoinWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform(activity_id, user_id, account_id, message, join_result)
    user = User.find(user_id)
    message = remarshal_message message
    account = PublicAccount.fetch(account_id)
    api = WechatService.instance.account_api account
    activity = Activity.find(activity_id)
    if $redis.get("need_reload:#{activity_id}").to_i == 1
      activity.load_activity
      $redis.del "need_reload:#{activity_id}"
    end
    Rails.logger.info "find activity: #{activity_id}"

    activity = "Activity#{activity_id}".constantize.new(
        activity,
        user, api, account, message, join_result
    )
    activity.start
  end

  private
  def remarshal_message(message_string)
    Wechat::Message.from_hash(Hash.from_xml(message_string)['xml'].symbolize_keys)
  end
end