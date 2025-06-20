desc "Start Foreman with development environment"
task :dev do
  sh "bundle exec foreman start"
end
