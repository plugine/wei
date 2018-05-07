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

      def start
  say "hello you are in activity, you result is #{join_result}"
  say "welcome to my homeland!"
end

    end
