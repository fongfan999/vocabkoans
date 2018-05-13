require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/puma'
require_relative 'mina/production'

set :repository, 'git@github.com:fongfan999/vocabkoans.git'
set :shared_dirs, fetch(:shared_dirs, []).push('tmp/sockets', 'tmp/pids')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key', '.env')

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
        invoke :'puma:restart'
      end
    end
  end
end
