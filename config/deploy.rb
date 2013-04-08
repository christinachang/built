require 'bundler/capistrano'

set :application, "built-app"
set :repository,  "git@github.com:flatiron-school/built.git"

set :user, 'Feline'
set :deploy_to, "/home/#{user}/#{application}"

set :use_sudo, false

set :scm, :git # You can set :scm explicitly or Capistrano will make an intelligent guess based on known version control directory names
# Or: `accurev`, `bzr`, `cvs`, `darcs`, `git`, `mercurial`, `perforce`, `subversion` or `none`
default_run_options[:pty] = true

role :web, "198.211.102.167"                          # Your HTTP server, Apache/etc
role :app, "198.211.102.167"                          # This may be the same as your `Web` server
role :db, "198.211.102.167", :primary => true

# if you want to clean up old releases on each deploy uncomment this:
# after "deploy:restart", "deploy:cleanup"

# if you're still using the script/reaper helper you will need
# these http://github.com/rails/irs_process_scripts
before 'deploy:assets:precompile', 'deploy:symlink_conf'

# If you are using Passenger mod_rails uncomment this:
namespace :deploy do
  task :start do ; end
  task :stop do ; end
  task :restart, :roles => :app, :except => { :no_release => true } do
    run "#{try_sudo} touch #{File.join(current_path,'tmp','restart.txt')}"
  end

  task :symlink_conf do
    run "ln -nfs #{shared_path}/database.yml #{release_path}/config/database.yml"
  end
end

desc "tail production log files"
task :tail_logs, :roles => :app do
  trap("INT") { puts 'Interupted'; exit 0; }
  run "tail -f #{shared_path}/log/production.log" do |channel, stream, data|
    puts  # for an extra line break before the host name
    puts "#{channel[:host]}: #{data}"
    break if stream == :err
  end
end
