class StorageService
  include Singleton

  def set(key, value, expire)
    $redis.pipelined do
      $redis.set key, value.to_s
      $redis.expire key, expire if expire.present?
    end
  end

  def get(key)
    $redis.get key
  end
end