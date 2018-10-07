task :production do
  set :rails_env, 'production'

  set :user, 'ubuntu'
  set :domain, '13.228.245.158'
  set :identity_file, '~/.ssh/ec2-default.pem'

  set :deploy_to, '/var/www/vocabkoans'
  set :branch, 'master'
end
