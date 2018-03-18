
lock '3.5.0'

set :application, 'wei'
set :repo_url, 'git@gitee.com:zhangzhongnan/wei.git'

set :rvm_ruby_version, '2.3.0'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch, ENV['branch'] || 'master'

set :deploy_to, "/var/apps/#{fetch(:application)}"

# Default value for :scm is :git
set :scm, :git
set :deploy_via, :remote_cache
set :copy_exclude, %w(.git)
set :normalize_asset_timestamps, false

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, false

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets public/assets public/uploads db/exports)

set(:custom_links, [
    {
        source: '/var/uploads',
        target: "#{fetch(:deploy_to)}/shared/public/uploads"
    }
])

# Default value for keep_releases is 5
set :keep_releases, 5

set :puma_init_active_record, true
set :puma_daemonize, true
set :puma_bind, %w(tcp://0.0.0.0:9292 unix:///tmp/puma.sock)

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'puma:restart'
    end
  end

  namespace :symlink do
    desc 'custom_links'
    task :custom do
      on roles(:app) do
        fetch(:custom_links).each do |link|
          source = link[:source]
          target = link[:target]
          unless test "[ -L #{target} ]"
            execute :rmdir, target if test "[ -d #{target} ]"
            execute :ln, '-nsf', source, target
          end
        end
      end
    end
  end

  after 'symlink:shared', 'symlink:custom'

  after :publishing, :restart
end
