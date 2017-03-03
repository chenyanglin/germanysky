# config valid only for current version of Capistrano
# lock '3.4.0'

`ssh-add` # need this to make key-forwarding work

set :application, 'germanysky'
# set :repo_url, 'ssh://git@gitlab.ideas.iii.org.tw:10022/150642/beaconserver.git'
set :repo_url, 'git@github.com:chenyanglin/germanysky.git'
set :git_https_username, 'chenyanglin'
set :git_https_password, 'xup6yaya'

current_branch = `git branch`.match(/\* (\S+)\s/m)[1]
set :branch, ENV['branch'] || current_branch || "master"


# set :rbenv_path, "/home/johnwu/.rbenv"
set :deploy_to, '/home/chenyang/germanysky'
set :tmp_dir, "/home/chenyang/tmp"
set :log_level, :debug
set :keep_releases, 5
# set :linked_files, %w(config/database.yml config/secrets.yml)
set :linked_dirs, fetch(:linked_dirs, []).push("bin", "log", "tmp/pids", "tmp/cache", "tmp/sockets", "vendor/bundle", "public/system","app/assets/images/brands/uploads","app/assets/images/products/uploads")
# set :default_env, { path: "~/.rbenv/shims:~/.rbenv/bin:$PATH" }

# rbenv 的設定
# set :rbenv_type, :user
# set :rbenv_ruby, "2.2.2"



# set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/bin/rbenv exec"
# set :rbenv_prefix, "RBENV_ROOT=#{fetch(:rbenv_path)} RBENV_VERSION=#{fetch(:rbenv_ruby)} #{fetch(:rbenv_path)}/shims/bundle exec"
# set :rbenv_map_bins, %w(rake gem bundle ruby rails)
# set :rbenv_roles, :all
set :passenger_restart_with_touch, true
# namespace :deploy do
#   after :restart, :clear_cache do
#     on roles(:web), in: :groups, limit: 3, wait: 10 do
#         execute :rake, 'cache:clear'
#     end
#   end
# end

#set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')
# ....

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

# Default deploy_to directory is /var/www/my_app_name
# set :deploy_to, '/var/www/my_app_name'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, fetch(:linked_files, []).push('config/database.yml', 'config/secrets.yml')

# Default value for linked_dirs is []
# set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
