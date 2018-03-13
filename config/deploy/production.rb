
hosts = %w(bhuser@boohee-tiger bhuser@boohee-lion bhuser@boohee-cat bhuser@boohee-monkey)
role :app, hosts
role :web, hosts
role :db,  %w(bhuser@boohee-lion)

set :rails_env, :production
set :unicorn_rack_env, :production

#sneakers-server
role :sneakers_server, %w(bhuser@boohee-cat bhuser@boohee-monkey)
set :sneakers_role, :sneakers_server

# set :whenever_roles, %w{bhuser@boohee-lion}

set :repo_url, 'git@boohee-panda:/opt/git/one.git'

# 在远程服务器部署时不需要经过 proxy
if `hostname`.strip != 'boohee-panda'
  require 'net/ssh/proxy/command'
  set :ssh_options, proxy:
      Net::SSH::Proxy::Command.new('ssh bhuser@boohee-panda -W %h:%p')
end
