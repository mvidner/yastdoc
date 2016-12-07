# config valid only for current version of Capistrano
lock '3.6.1'

set :application, 'yastdoc'
set :repo_url, 'https://github.com/mvidner/yastdoc.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp

dir = '/home/jenkins/capistrano'
# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, dir

task :restart_services do
  on roles(:app), in: :sequence do
    execute "pkill -f bin/yastdoc || true"
    execute "cd #{dir}/current; LANG=en_US screen -S yastdoc -d -m rake run"
  end
end

after "deploy:finishing", :restart_services

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :airbrussh.
# set :format, :airbrussh

# You can configure the Airbrussh format using :format_options.
# These are the defaults.
# set :format_options, command_output: true, log_file: 'log/capistrano.log', color: :auto, truncate: :auto

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# append :linked_files, 'config/database.yml', 'config/secrets.yml'

# Default value for linked_dirs is []
# append :linked_dirs, 'log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'public/system'
append :linked_dirs, "public/dochost/github"

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
# set :keep_releases, 5
