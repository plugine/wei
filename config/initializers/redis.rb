redis_url =
    if Rails.env.production?
      'redis://192.168.1.7:6379/0'
    elsif Rails.env.qa?
      'redis://192.168.1.33:6379/0'
    else
      'redis://localhost:6379/0'
    end

$redis = Redis.new(url: redis_url)