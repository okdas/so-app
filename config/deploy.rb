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

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end

before 'deploy:update_code', 'thinking_sphinx:stop'
after  'deploy:update_code', 'thinking_sphinx:start'

namespace :sphinx do
  desc "Symlink Sphinx indexes"
  task :symlink_indexes, :roles => [:app] do
    run "ln -nfs #{shared_path}/db/sphinx #{release_path}/db/sphinx"
  end
end

after 'deploy:finalize_update', 'sphinx:symlink_indexes'