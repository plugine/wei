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

      text '欢迎参加这个活动啊'
    end
