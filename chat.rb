#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'data_mapper'
require 'bcrypt'

set :environment, :development

set :protection , :except => :session_hijacking

configure :development do

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/mydatabase.db" )
end

configure :production do
DataMapper.setup(:default,ENV['HEROKU_POSTGRESQL_RED_URL'])
end

DataMapper::Logger.new($stdout, :debug)
DataMapper::Model.raise_on_save_failure = true

require_relative 'model'

DataMapper.finalize

#DataMapper.auto_migrate!
DataMapper.auto_upgrade!

enable :sessions
set :session_secret, '*&(^#234a)'

get '/' do

  haml :index

end

post '/chat' do

  nickname = params[:nickname]
  password = params[:password]
  user = User.first(:nickname => nickname)
  pass = nil

  @error = nil

  if user.password == params[:password]
    pass = user.password

  if User.count(:nickname => nickname , :password => pass) == 0
    @error = "error"
    haml :index , :layout => false
  else
    haml :chat , :layout => false
  end

  else

    @error = "error"
    haml :index , :layout => false
  end


end

get '/help' do

  haml :help

end

get '/about' do

  haml :about

end

get '/registro' do

  haml :registro

end

post '/registro' do

  user = User.new

  user.nickname = params[:nickname]
  user.password = params[:password]

  puts params[:nickname]
  puts params[:password]

  @error = nil

  if User.count(:nickname => user.nickname) == 0
      user.save
      @error = "success"
  else
      @error = "error"
  end


  haml :registro

end
