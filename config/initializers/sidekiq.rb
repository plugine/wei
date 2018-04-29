redis_url = 'redis://localhost:6379/0'

Sidekiq.configure_server do |config|
  config.redis = { url: redis_url, namespace: 'wei' }
end

Sidekiq.configure_client do |config|
  config.redis = { url: redis_url, namespace: 'wei' }
end

Sidekiq.default_worker_options = { retry: 3, backtrace: true }
