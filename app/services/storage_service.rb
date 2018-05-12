class StorageService
  include Singleton

  def set(key, value, expire)
    $redis.pipelined do
      $redis.set key, value.to_s
      $redis.expire key, expire if expire.present?
    end
  end

  def append(key, value, expire)
    set key, "#{value.to_s}\n\n-------\n\n#{get(key)}", expire
  end

  def get(key)
    $redis.get key
  end
end