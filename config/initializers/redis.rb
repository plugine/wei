redis_url = 'redis://localhost:6379/0'
ssdb_url = 'redis://localhost:8888/0'

$redis = Redis.new(url: redis_url)
$ssdb = Redis.new(url: ssdb_url)