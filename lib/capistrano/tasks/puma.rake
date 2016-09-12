namespace :puma do
  desc 'Setup Puma configuration and systemd'
  task :setup do
    on roles(:app) do
      execute :mkdir, "-p #{shared_path}/config"

      # Puma configuration
      template 'puma.erb', fetch(:puma_config)

      # Systemd for puma
      execute :sudo, :rm, '-f /tmp/puma_systemd'
      template 'puma_systemd.erb', '/tmp/puma_systemd', true
      execute :sudo, :mv, "/tmp/puma_systemd /lib/systemd/system/#{fetch(:application_env)}.service"
      execute :sudo, :systemctl, "enable #{fetch(:application_env)}"
    end
  end

  desc 'Status Puma'
  task :status do
    on roles(:app) do
      capture :systemctl, "status #{fetch(:application_env)}"
    end
  end

  %w[start stop].each do |command|
    desc "#{command.capitalize} Puma"
    task command do
      on roles(:app) do
        execute :sudo, :systemctl, "#{command} #{fetch(:application_env)}"
      end
    end
  end

  desc 'Hot restart Puma'
  task 'hot-restart' do
    on roles(:app) do
      execute :kill, "-s SIGUSR2 `cat #{fetch(:puma_pid)}`"
    end
  end

  %w[restart phased-restart].each do |command|
    desc "#{command.gsub('_', ' ').capitalize} Puma"
    task command do
      on roles(:app) do
        within current_path do
          execute :bundle, :exec,  "pumactl -S #{fetch(:puma_state)} -F #{fetch(:puma_config)} #{command}"
        end
      end
    end
  end

  desc 'Remove Puma configuration and systemd'
  task :remove do
    on roles(:app) do
      invoke 'puma:stop'
      execute :sudo, :systemctl, "disable #{fetch(:application_env)}"
      execute :sudo, :rm, "-f /usr/lib/systemd/system/#{fetch(:application_env)}.service"
    end
  end
end
