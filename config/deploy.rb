require 'mina/bundler'
require 'mina/rails'
require 'mina/git'
# require 'mina/rbenv'
require 'mina/rvm'

# Basic settings:
#   domain       - The hostname to SSH to.
#   deploy_to    - Path to deploy into.
#   repository   - Git repo to clone from. (needed by mina/git)
#   branch       - Branch name to deploy. (needed by mina/git)

# Old
# set :user , 'root'
# set :domain, '119.9.77.207'
# set :deploy_to, '/opt/projects/shop'
# set :repository, '/opt/projects/shop.git'

set :user , 'liwei'
set :domain, '182.92.218.119'
set :deploy_to, '/home/liwei/deploy'
set :repository, 'git@git.coding.net:liwei78/peaudefee.git'
set :branch, 'master'
set :env, 'production'

task :v2 do
  set :user , 'liwei'
  set :domain, 'ali-hk.wangboshi.net'
  set :deploy_to, '/home/liwei/staging'
  set :repository, 'git@git.coding.net:liwei78/peaudefee.git'
  set :tag, lambda { "release/#{version}" }
  set :version, "v2.0.0"
  set :env, 'production'   # socket file name
end

task :v1 do
  set :user , 'liwei'
  set :domain, 'ali-hk.wangboshi.net'
  set :deploy_to, '/home/liwei/deploy'
  set :repository, 'git@git.coding.net:liwei78/peaudefee.git'
  set :tag, lambda { "release/#{version}" }
  set :version, "v1.0.0"
  set :env, 'production'
end

# Manually create these paths in shared/ (eg: shared/config/database.yml) in your server.
# They will be linked in the 'deploy:link_shared_paths' step.
set :shared_paths, ['config/database.yml', 'config/secrets.yml', 'config/settings.yml', 'log', 'tmp', 'public/spree', 'public/assets', 'public/pdf']

task :environment do
  # invoke :'rbenv:load'
  invoke :'rvm:use[ruby-2.2.2@peaudefee]'
end

# Put any custom mkdir's in here for when `mina setup` is ran.
# For Rails apps, we'll make some of the shared paths that are shared between
# all releases.
task :setup => :environment do
  task :enviroproductiono
  ["config", "log", "tmp", "public/spree", "public/assets"].each do |folder|
    # invoke :'rbeproduction'
    queue! %[mkdir -p "#{deploy_to}/#{shared_path}/#{folder}"]
    queue! %[chmod g+rx,u+rwx "#{deploy_to}/#{shared_path}/#{folder}"]
  end

  queue! %[mkdir -p "#{deploy_to}/tmp/pids"]
  queue! %[chmod g+rx,u+rwx "#{deploy_to}/tmp/pids"]

  queue! %[touch "#{deploy_to}/#{shared_path}/config/database.yml"]
  queue  %[echo "-----> Be sure to edit '#{deploy_to}/#{shared_path}/config/database.yml'."]
end

desc "Deploys the current version to the server."
task :deploy => :environment do
  deploy do
    # Put things that will set up an empty directory into a fully set-up
    # instance of your project.
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    to :launch do
      # queue "mkdir -p #{deploy_to}/#{current_path}/tmp/"
      # queue! "RAILS_ENV=production bundle exec rake restart_puma"
      # queue! "bundle exec rake restart_unicorn"
      # queue! "ln -sv #{deploy_to}/#{shared_path}/public/spree #{deploy_to}/#{current_path}/public/spree"
      invoke :'server:restart'
    end
  end
end

namespace :server do
  desc 'Stop'
  task stop: :environment do
    queue! %[
       kill `cat #{deploy_to}/tmp/pids/unicorn.pid`
    ]
    queue  %[echo "-----> #{Time.now.to_s} Stopped."]
  end

  desc 'Start'
  task start: :environment do
    queue! %[
      cd #{deploy_to}/#{current_path} && bundle exec unicorn -c config/unicorn/#{env}.rb -D -E production
    ]
    queue  %[echo "-----> #{Time.now.to_s} Started."]
  end

  desc 'Restart'
  task restart: :environment do
    invoke :'server:stop'
    invoke :'server:start'
  end
end
