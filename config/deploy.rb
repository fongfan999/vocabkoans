require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/puma'
require 'mina_sidekiq/tasks'

require_relative 'mina/whenever'
require_relative 'mina/environments/production'

set :application_name, 'vocabkoans'
set :repository, 'git@github.com:fongfan999/vocabkoans.git'
set :shared_dirs, fetch(:shared_dirs, []).push('tmp/sockets', 'tmp/pids')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key', '.env')
set :sidekiq_pid, -> { "#{fetch(:shared_path)}/tmp/pids/sidekiq.pid" }

task :remote_environment do
  invoke :'rvm:use', '2.5.1@vocabkoans'
end

task :deploy do
  deploy do
    invoke :'git:clone'
    invoke :'deploy:link_shared_paths'
    invoke :'bundle:install'
    invoke :'rails:db_migrate'
    invoke :'rails:assets_precompile'
    invoke :'deploy:cleanup'

    on :launch do
      in_path(fetch(:current_path)) do
        invoke :'sidekiq:quiet'
        invoke :'whenever:update'
        invoke :'puma:restart'
        invoke :'sidekiq:restart'
      end
    end
  end
end
