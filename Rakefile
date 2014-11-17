desc "Run capybara test"
task :default => :test

desc "Run capybara test"
task :test do
  sh "ruby test/test.rb"
end

desc "Run server with sinatra"
task :init do
  sh "ruby chat.rb"
end

desc "Run server with rackup"
task :rack do
  sh "rackup"
end

desc "Deploy on heroku"
task :deploy do
  sh "git push heroku master"
end

desc "Ps heroku"
task :ps do
  sh "heroku ps"
end
