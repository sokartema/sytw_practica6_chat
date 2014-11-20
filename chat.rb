#!/usr/bin/env ruby
# encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader' if development?
require 'haml'
require 'data_mapper'
require 'bcrypt'

set :environment, :production

set :protection , :except => :session_hijacking
chat=[]
online=[]

configure :development do

DataMapper.setup(:default, ENV['DATABASE_URL'] || "sqlite3://#{Dir.pwd}/mydatabase.db" )
end

configure :production do

DataMapper.setup(:default,ENV['HEROKU_POSTGRESQL_TEAL_URL'])

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

  if(params[:nickname] == nil)

        nickname = "Anonimo-" + BCrypt::Password.create(rand(10000000000000)).to_s.slice(20,5)
        session[:nickname] = nickname
        if online.index(nickname) != nil
          @error = "error"
          haml :index , :layout => false
        else
          online << nickname		#add user online
          haml :chat , :layout => false
        end


  else

      nickname = params[:nickname]
      password = params[:password]
      user = User.first(:nickname => nickname)
      pass = nil
      session[:nickname] = nickname

      @error = nil

      if user.password == params[:password]
        pass = user.password

      if User.count(:nickname => nickname , :password => pass) == 0 || online.index(nickname) != nil
        @error = "error"
        haml :index , :layout => false
      else
        online << nickname		#add user online
        haml :chat , :layout => false
      end

      else

        @error = "error"
        haml :index , :layout => false
      end

  end

end

get '/send' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  chat << "[#{Time.new.hour} : #{Time.new.min}] #{session[:nickname]} > #{params['text']}"
  nil

end

get '/update' do
  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = chat[params['last'].to_i..-1] || []

  @last = chat.size
  erb <<-'HTML', :layout => false
      <% @updates.each do |phrase| %>
        <%= phrase %> <br />
      <% end %>
      <span data-last="<%= @last %>"></span>
  HTML
end

get '/updateusers' do

  return [404, {}, "Not an ajax request"] unless request.xhr?
  @updates = online[params['users'].to_i..-1] || []

  @users = online.size
  erb <<-'HTML', :layout => false
  <% @updates.each do |phrase| %>
    <%= phrase %> <br />
    <% end %>
    <span data-last="<%= @last %>"></span>
    HTML


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

  @error = nil

  if User.count(:nickname => user.nickname) == 0
      user.save
      @error = "success"
  else
      @error = "error"
  end


  haml :registro

end

get '/logout' do

  online.delete_at(online.index(session[:nickname]))

  session.clear

  redirect '/'

end
