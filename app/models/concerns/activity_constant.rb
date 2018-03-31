module ActivityConstant
  extend ActiveSupport::Concern

  included do
    def joined_list_key(activity_id)
      "activity:#{activity_id}:joined"
    end

    def rank_list_key(activity_id)
      "activity:#{activity_id}:rank"
    end

    def user_supporters_key(activity_id, user_id)
      "activity:#{activity_id}:user_supporters:#{user_id}"
    end

    def user_profile_key(user_id)
      "user_profile:#{user_id}"
    end
  end
end