    class Activity2
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

      text :welcome, 'Hi #{user.nickname}~\n欢迎参加我的活动'

def start
  say welcome
end
    end
