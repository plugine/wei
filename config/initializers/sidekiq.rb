redis_url =
    if Rails.env.production?
      'redis://192.168.1.7:6379/0'
    elsif Rails.env.qa?
      'redis://192.168.1.33:6379/0'
    else
      'redis://localhost:6379/0'
    end

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, namespace: 'wei' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, namespace: 'wei' }
end

Sidekiq.default_worker_options = { retry: 3, backtrace: true }
