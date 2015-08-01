set :application, 'ruswizards_shop'
set :repo_url, 'git@github.com:storuky/ruswizards_shop.git'
# set :rvm_type, :user

set :bundle_path, nil
set :bundle_flags, '--system'

# set :rvm_bin_path, "/home/deploy/.rvm/bin"

set :deploy_to, '/home/deploy/ruswizards_shop'

set :linked_files, %w{config/database.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system public/uploads}

# Default branch is :master
# ask :branch, proc { `git rev-parse --abbrev-ref HEAD`.chomp }

# Default deploy_to directory is /var/www/my_app
# set :deploy_to, '/var/www/my_app'

# Default value for :scm is :git
# set :scm, :git

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
# set :linked_files, %w{config/database.yml}

# Default value for linked_dirs is []
# set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

# Default value for default_env is {}
# set :default_env, { path: "/opt/ruby/bin:$PATH" }

# Default value for keep_releases is 5
set :keep_releases, 2

namespace :deploy do
  # desc 'Start application'
  # task :start do
  #   run  <<-CMD
  #     cd /home/deploy/agrofor/current; RAILS_ENV=production bundle exec rackup private_pub.ru -s thin -E production
  #   CMD
  # end

  desc 'Restart application'
  task :restart do
    # sudo "rackup private_pub.ru -s thin -E production"
    on roles(:app), in: :sequence, wait: 5 do
      execute :touch, release_path.join('tmp/restart.txt')
    end
  end

  after :publishing, 'deploy:restart'
  after :finishing, 'deploy:cleanup'
  after  "deploy", "thinking_sphinx:configure"
  after  "deploy", "thinking_sphinx:rebuild"
end
