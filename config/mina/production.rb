task :production do
  set :user, 'ubuntu'
  set :domain, '13.229.229.72'
  set :identity_file, '~/.ssh/ec2-default.pem'

  set :deploy_to, '/var/www/vocabkoans'
  set :branch, 'master'
end
