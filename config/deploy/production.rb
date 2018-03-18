
hosts = %w(root@47.97.202.227)
role :app, hosts
role :web, hosts
role :db,  hosts

set :rails_env, :production

set :repo_url, 'git@gitee.com:zhangzhongnan/wei.git'