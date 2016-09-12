namespace :rvm do
  desc 'Create alias on rvm'
  task :create_alias do
    on roles(:app) do
      execute :rvm, :alias, "create #{fetch(:application_env)} ruby-#{fetch(:rvm_ruby_version)}@#{fetch(:application_env)}"
    end
  end

  task :delete_alias do
    on roles(:app) do
      execute :rvm, :alias, "delete #{fetch(:application_env)}"
    end
  end
end
