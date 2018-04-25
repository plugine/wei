module Userable
  extend ActiveSupport::Concern

  # 加入一个活动
  def join_activity(activity_id, base: true, base_user_id: 0)
    Rails.logger.info "act_id: #{activity_id}, base: #{base}, base_user_id: #{base_user_id}, self.id: #{self.id}"
    if self.joined_activity? activity_id
      return ErrorConst::JOINED if base
      if relaied_user_id(activity_id) == 0
        return ErrorConst::USER_RELAY_SELF if base_user_id == self.id
        return relay(activity_id, base_user_id)
      end
      return ErrorConst::USER_RELAIED
    end


    $redis.pipelined do
      # 更新用户信息
      $redis.set user_profile_key(self.id), {
          id: self.id,
          nickname: self.nickname,
          headimgurl: self.headimgurl
      }.to_json

      # 更新加入表
      $redis.zadd joined_list_key(activity_id), base_user_id, self.id

      # 更新接力用户排名表(初始排名为0)
      $redis.zadd rank_list_key(activity_id), 0, self.id

      # 将自己的ID加入上家的支持者列表中
      ($redis.zadd user_supporters_key(activity_id, base_user_id), Time.now.to_i, self.id)  unless base

      # 更新上家活动排名
      ($redis.zincrby rank_list_key(activity_id), 1, base_user_id) unless base
    end

    ErrorConst::JOIN_SUCCESS
  end

  # 判断用户是否加入一个活动，加入了返回true，未加入返回false
  def joined_activity?(activity_id)
    ($redis.zscore joined_list_key(activity_id), self.id) == nil ? false : true
  end

  # 接力一个用户，针对扫母码参与活动的用户使用
  def relay(activity_id, base_user_id)
    $redis.pipelined do
      # 更新自己的上家id
      $redis.zincrby joined_list_key(activity_id), base_user_id, self.id

      # 更新上家的接力者列表
      $redis.zadd user_supporters_key(activity_id, base_user_id), Time.now.to_i, self.id

      # 更新上家的排名
      $redis.zincrby rank_list_key(activity_id), 1, base_user_id
    end

  end

  # 当前接力的用户的ID，如果没有上家，返回0
  def relaied_user_id(activity_id)
    score = ($redis.zscore joined_list_key(activity_id), self.id)
    score.to_i
  end

  # 我的支持者列表
  def supporters(activity_id)
    $redis.zrevrange user_supporters_key(activity_id, self.id), 0, -1
  end

end