
hosts = %w(root@five)
role :app, hosts
role :web, hosts
role :db,  hosts

set :rails_env, :production

set :repo_url, 'git@github.com:plugine/wei.git'

set :puma_state, "#{shared_path}/tmp/pids/puma.state"
set :puma_pid,   "#{shared_path}/tmp/pids/puma.pid"
set :puma_bind, 'unix:///tmp/puma.sock' #根据nginx配置链接的sock进行设置，需要唯一
set :puma_conf, "#{shared_path}/puma.rb"
set :puma_access_log, "#{shared_path}/log/puma_error.log"
set :puma_error_log, "#{shared_path}/log/puma_access.log"
set :puma_role, :app
set :puma_env, fetch(:rack_env, fetch(:rails_env, 'production'))
set :puma_threads, [0, 16]
set :puma_workers, 0
set :puma_init_active_record, false
set :puma_preload_app, true

set :sidekiq_role, :app
set :sidekiq_config, "#{current_path}/config/sidekiq.yml"
set :sidekiq_env, 'production'