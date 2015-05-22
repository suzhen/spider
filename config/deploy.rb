# config valid only for current version of Capistrano
lock '3.4.0'

set :application, 'spider'
set :repo_url, 'https://github.com/suzhen/spider.git'

# Default branch is :master
# ask :branch, `git rev-parse --abbrev-ref HEAD`.chomp
set :branch,'master'

# Default deploy_to directory is /var/www/my_app_name
set :deploy_to, '/var/www/spider'

set :bundle_flags, '--deployment'

set :bundle_gemfile, -> { release_path.join('Gemfile') }


# Default value for :scm is :git
set :scm, :git

set :chruby_ruby, 'ruby-2.2.1'

set :bundle_binstubs, nil

# Default value for :format is :pretty
# set :format, :pretty

# Default value for :log_level is :debug
# set :log_level, :debug

# Default value for :pty is false
# set :pty, true

# Default value for :linked_files is []
set :linked_files, fetch(:linked_files, []).push('config/database.yml','config/boot_app.yml')

# Default value for linked_dirs is []
set :linked_dirs, fetch(:linked_dirs, []).push('log', 'tmp/pids', 'tmp/cache', 'tmp/sockets', 'vendor/bundle', 'public/system')

# Default value for default_env is {}
set :default_env, { path: "/opt/rubies/ruby-2.2.1/bin:$PATH" }


# Default value for keep_releases is 5
set :keep_releases, 5

namespace :deploy do

  task :restart_thin  do
    on roles(:web),in: :sequence, wait: 3 do
      within release_path do
        execute :bundle,"exec thin restart -C /var/www/spider/shared/config/boot_app.yml"
      end
    end

  end


  after :published, :restart_thin

end
