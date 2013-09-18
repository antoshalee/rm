default_run_options[:pty] = true
set :application, "Remix"
ssh_options[:forward_agent] = true
set :repository,  "git@github.com:antoshalee/rm.git"
set :deploy_to, "/usr/share/nginx/html"
set :scm, :git
set :deploy_via, :remote_cache
set :user, "nginx"
set :rails_env, "production"
set :use_sudo, false
set :keep_releases, 3

server "212.41.1.244", :app, :web, :db, :primary => true

after "deploy:restart", "deploy:cleanup"
require "bundler/capistrano"

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