set :rails_env, 'production'
set :user, ENV['PRODUCTION_USER']
set :host, ENV['PRODUCTION_HOST']
set :port, ENV['PRODUCTION_PORT']
set :application_env, "#{fetch :application }_#{fetch :rails_env}"
set :deploy_to, "/var/apps/#{fetch :application_env}"

server fetch(:host), user: fetch(:user), roles: %w{web app db}, port: fetch(:port)
