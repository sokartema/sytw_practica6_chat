# -*- coding: utf-8 -*-
require 'coveralls'
Coveralls.wear!
ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'rack/test'
require 'rubygems'
require 'rspec'

include Rack::Test::Methods
describe "Test APP chat: Comprobacion de funciones" do

  def app
    Sinatra::Application
  end


  it "Cierre de sesion" do
    get '/logout'
    expect(last_response.body).to eq("<h1>Not Found</h1>")
  end

  it "Envio con sesion" do
    get '/send', {}, 'rack.session' => { :name => 'Prueba' }
    expect(last_response.body).to eq("Not an ajax request")
  end

  it "Envio con sesion HTTP_X_REQUESTED_WITH" do
    get '/send', {}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest" ,'rack.session' => { :name => 'Prueba' }}
    expect(last_response.body).to eq("")
  end

  it "index" do
    get '/'
    (expect(last_response.status).to eq(200))
  end

  it "Envio sin sesion" do
    get '/send',env = {}
    expect(last_response.body).to eq("Not an ajax request")
  end

  it "Update" do
    get '/update'
    expect(last_response.body).to eq("Not an ajax request")
  end

  it "Post chat" do
    post '/chat',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
    expect(last_response).to be_ok

  end

  it "Update HTTP_X_REQUESTED_WITH" do
    get '/update',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
    expect(last_response).to be_ok
  end

  it "User" do
    get '/user'
    expect(last_response.body).to eq("<h1>Not Found</h1>")
  end

  it "Update Users" do
    get '/updateusers',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
    expect(last_response).to be_ok
  end

  it "Help" do
    get '/help',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
    expect(last_response).to be_ok
  end

  it "About" do
    get '/about',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
    expect(last_response).to be_ok
  end

  it "Registro" do
    get '/registro',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
    expect(last_response).to be_ok
  end

  it "chat update" do
    get '/chat/update'
    expect(last_response.body).to eq("<h1>Not Found</h1>")
  end

  it "Crea nuevo link" do
      prueba=User.new(:nickname => "Prueba")
      expect(prueba.save).to eq(true)
  end

  it "Borra el link" do
      prueba=User.first(:nickname => "Prueba")
      expect(prueba.destroy).to eq(true)
  end

  it "Comprueba si esta el CSS en el servidor" do
		@css="/public/css/groundwork.css"
		path = File.absolute_path(__FILE__)
		path=path+@css
		path=path.split('/test/rspec_test.rb')
		path=path[0]+path[1]

	expect (File.exists?(path))
    end

    it "Registro" do
      post '/registro',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
      expect(last_response).to be_ok
    end

    it "logout/index" do
      get '/logout/index'
      (expect(last_response.status).to eq(500))
    end


    it "Comprueba si esta el Javascript en el servidor" do
		@js="/public/js/chat.js"
		path = File.absolute_path(__FILE__)
		path=path+@js
		path=path.split('/test/rspec_test.rb')
		path=path[0]+path[1]

	expect (File.exists?(path))
    end

end
