# Environment configuration
set :rails_env, 'production'
set :user, ENV['PRODUCTION_USER']
set :host, ENV['PRODUCTION_HOST']
set :port, ENV['PRODUCTION_PORT']
set :application_env, "#{fetch :application }_#{fetch :rails_env}"
set :deploy_to, "/var/apps/#{fetch :application_env}"

# Nginx configuration
set :server_name, ENV['PRODUCTION_SERVER_NAME']

# Puma configuration
set :puma_config,  -> { "#{shared_path}/config/puma.rb" }
set :puma_pid,     -> { "#{current_path}/tmp/puma.pid" }
set :puma_sock,    -> { "#{current_path}/tmp/puma.sock" }
set :puma_state,   -> { "#{current_path}/tmp/puma.state" }
set :puma_log,     -> { "#{current_path}/log/puma.log" }
set :puma_workers, 2
set :puma_threads, '0, 16'

# Server
server fetch(:host), user: fetch(:user), roles: %w{web app db}, port: fetch(:port)

append :linked_files, '.env.production'
