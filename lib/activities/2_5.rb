class Activity5
  include ErrorConst
  include Activitiable

  def initialize(activity, user, api, account, message, join_result)
    @activity = activity
    @user = user
    @api = api
    @account = account
    @message = message
    @join_result = join_result
  end

  def start
    say '欢迎参加活动'
  end
end
