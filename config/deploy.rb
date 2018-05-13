require 'mina/rails'
require 'mina/git'
require 'mina/rvm'
require 'mina/puma'

set :repository, 'git@github.com:fongfan999/vocabkoans.git'
set :shared_dirs, fetch(:shared_dirs, []).push('tmp/sockets', 'tmp/pids')
set :shared_files, fetch(:shared_files, []).push('config/database.yml', 'config/master.key', '.env')

task :production do
  set :user, 'ubuntu'
  set :domain, '13.229.229.72'
  set :identity_file, '~/.ssh/ec2-default.pem'

  set :deploy_to, '/var/www/vocabkoans'
  set :branch, 'master'
end

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
