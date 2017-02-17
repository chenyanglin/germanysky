# Load DSL and set up stages
require 'capistrano/setup'

# Include default deployment tasks
require 'capistrano/deploy'

# Include tasks from other gems included in your Gemfile
#
# For documentation on these, see for example:
#
#   https://github.com/capistrano/rvm
#   https://github.com/capistrano/rbenv
#   https://github.com/capistrano/chruby
#   https://github.com/capistrano/bundler
#   https://github.com/capistrano/rails
#   https://github.com/capistrano/passenger
#
 require 'capistrano/rails'
 #require 'capistrano/rbenv'
# require 'capistrano/chruby'
 require 'capistrano/bundler' # 會自動幫你跑 bundle install
 require 'capistrano/rails/assets' # 會自動幫你跑 rake assets:precompile
 require 'capistrano/rails/migrations' # 會自動幫你跑 rake db:migrate
 require 'capistrano/passenger'

# Load custom tasks from `lib/capistrano/tasks` if you have any defined
Dir.glob('lib/capistrano/tasks/*.rake').each { |r| import r }
