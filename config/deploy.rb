
lock '3.5.0'

set :application, 'one'
set :repo_url, 'git@git.boohee.cn:ruby/one.git'

set :rvm_ruby_version, '2.3.0'

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :branch, ENV["branch"] || "master"

# Default deploy_to directory is /var/www/my_app
set :deploy_to, "/var/apps/#{fetch(:application)}"

# Default value for :scm is :git
set :scm, :git
set :deploy_via, :remote_cache
set :copy_exclude, %w(.git)
set :normalize_asset_timestamps, false

# tmp/pids 是 link 目录
set :sidekiq_pid, 'tmp/pids/sidekiq.pid'

# Default value for :format is :pretty
set :format, :pretty

# Default value for :log_level is :debug
set :log_level, :debug

# Default value for :pty is false
set :pty, false

set :sneakers_run_config, true
set :sneakers_pid, "tmp/pids/sneakers.pid"
# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
set :linked_dirs, %w(log tmp/pids tmp/cache tmp/sockets public/assets public/house db/exports photos/id_photos)

set(:custom_links, [
    {
        source: '/mfs/one/house',
        target: "#{fetch(:deploy_to)}/shared/public/house"
    },
    {
        source: '/mfs/one/db-exports',
        target: "#{fetch(:deploy_to)}/shared/db/exports"
    },
    {
        source: '/mfs/one/id-photos',
        target: "#{fetch(:deploy_to)}/shared/photos/id_photos"
    }
])

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 5

# unicorn.rb 路径
set :unicorn_config_path, "#{fetch(:deploy_to)}/current/config/unicorn.rb"

namespace :deploy do
  desc 'Restart application'
  task :restart do
    on roles(:app), in: :sequence, wait: 5 do
      invoke 'unicorn:restart'
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
