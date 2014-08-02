# config valid only for Capistrano 3.1
lock '3.2.1'

set :application, 'soapp'
set :repo_url, 'git@github.com:okdas/so-app.git'

set :deploy_to, '/home/soapp/web'
set :deploy_user, 'soapp'
set :linked_files, %w{config/database.yml .env}

set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

set :default_shell, '/bin/bash -l'

after 'deploy:publishing', 'deploy:restart'

before 'deploy:publishing', 'thinking_sphinx:stop'
after 'deploy:publishing', 'thinking_sphinx:start'
after 'thinking_sphinx:start', 'thinking_sphinx:index'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end