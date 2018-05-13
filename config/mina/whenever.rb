set :whenever_name, -> { "#{fetch(:application_name)}_#{fetch(:rails_env)}" }

namespace :whenever do
  desc 'Update crontab'
  task update: :remote_environment do
    comment "Update crontab for #{fetch(:application_name)}"
    in_path fetch(:current_path) do
      command "#{fetch(:bundle_prefix)} whenever --update-crontab #{fetch(:whenever_name)}"
    end
  end
end
