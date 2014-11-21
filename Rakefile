desc "Run tests"
task :default => :rspec

desc "Run capybara test"
task :capybara do
  sh "ruby test/test_c.rb"
end

desc "Run all test"
task :test do
  sh "ruby test/test.rb"
end

desc "Run Selenium test"
task :selenium do
  sh "ruby test/test_s.rb"
end

desc "Run unitary test"
task :unittest do
  sh "ruby test/test_u.rb"
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

desc "Test rspec"
task :rspec do
  sh "rspec -I. test/rspec_test.rb"
end
