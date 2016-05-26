desc '重启生产环境的puma'
task :restart_puma => :environment do
  system "kill -s USR2 `cat /opt/projects/shop/tmp/puma.pid`"
  Dir.chdir "/opt/projects/shop/current"
  system "puma -C config/puma.rb"
end
desc "重启服务器上unicorn"
task :restart_unicorn do
  root = File.expand_path('../../../../../', __FILE__)
  system "kill `cat #{root}/tmp/pids/unicorn.pid`"
  Dir.chdir root + '/current'
  system "bundle exec unicorn -c config/unicorn.rb -D -E production"
end
desc '重新编译生产环境的样式'
task :recompile_production do
  system "RAILS_ENV=production bundle exec rake assets:clean"
  system "RAILS_ENV=production bundle exec rake assets:precompile"
end
desc '重新编译开发环境的样式'
task :recompile_development do
  system "RAILS_ENV=development bundle exec rake assets:clean"
  system "RAILS_ENV=development bundle exec rake assets:precompile"
end