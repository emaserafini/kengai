namespace :nginx do
  desc 'Configure Nginx to run with puma'
  task :setup do
    on roles(:web) do
      execute :sudo, :rm, '-f /tmp/nginx_conf'
      template 'nginx_puma.erb', "/tmp/nginx_conf", true
      execute :sudo, :mkdir, '-p /etc/nginx/sites-available'
      execute :sudo, :mkdir, '-p /etc/nginx/sites-enabled'
      execute :sudo, :mv, "/tmp/nginx_conf /etc/nginx/sites-available/#{fetch(:application_env)}"
      execute :sudo, :ln, "-sf /etc/nginx/sites-available/#{fetch(:application_env)} /etc/nginx/sites-enabled/#{fetch(:application_env)}"
    end
    after 'nginx:setup', 'nginx:restart'
  end


  desc 'Status Nginx'
  task :status do
    on roles(:app) do
      capture :systemctl, 'status nginx'
    end
  end

  %w[start stop restart].each do |command|
    desc "#{command.capitalize} Nginx"
    task command do
      on roles(:web) do
        execute :sudo, "systemctl #{command} nginx"
      end
    end
  end

  desc 'Remove Nginx configuration'
  task :remove do
    on roles(:web) do
      execute :sudo, :rm, "/etc/nginx/sites-enabled/#{fetch :application_env}"
      execute :sudo, :rm, "-f /etc/nginx/sites-available/#{fetch :application_env}"
      invoke 'nginx:restart'
    end
  end
end
