default_run_options[:pty] = true
set :application, "Remix"
ssh_options[:forward_agent] = true
set :repository,  "git@github.com:antoshalee/rm.git"
set :deploy_to, "/home/deploy/site"
set :scm, :git
set :deploy_via, :remote_cache
set :user, "deploy"
set :rails_env, "production"
set :use_sudo, false
set :keep_releases, 3
set :shared_children, shared_children + %w{public/uploads}

# === Unicorn ====
set :unicorn_conf, "#{deploy_to}/current/config/unicorn.rb"
set :unicorn_pid, "#{deploy_to}/shared/pids/unicorn.pid"

server "188.225.35.32", :app, :web, :db, :primary => true

after "deploy:restart", "deploy:cleanup"
require "rvm/capistrano"
require "bundler/capistrano"
require "whenever/capistrano"
set :whenever_command, "bundle exec whenever"

before "deploy:assets:precompile" do
  run "ln -s #{shared_path}/application.yml #{release_path}/config/"
end

namespace :deploy do
  task :restart do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -USR2 `cat #{unicorn_pid}`; else cd #{deploy_to}/current && bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D; fi"
  end
  task :start do
    run "bundle exec unicorn_rails -c #{unicorn_conf} -E #{rails_env} -D"
  end
  task :stop do
    run "if [ -f #{unicorn_pid} ] && [ -e /proc/$(cat #{unicorn_pid}) ]; then kill -QUIT `cat #{unicorn_pid}`; fi"
  end
end

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts

# If you are using Passenger mod_rails uncomment this:
# namespace :deploy do
#   task :start do ; end
#   task :stop do ; end
#   task :restart, :roles => :app, :except => { :no_release => true } do
#     run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
#   end
# end