#!/usr/bin/env ruby
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'

set :environment, :development

enable :sessions
set :session_secret, '*&(^#234a)'

get '/' do

  haml :index

end

post '/chat' do

  @nickname = params[:nickname]

  haml :chat , :layout => false
end

get '/help' do

  haml :help

end

get '/about' do

  haml :about

end
