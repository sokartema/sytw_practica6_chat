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

  it "Envio sin sesion" do
    get '/send',env = {}
    expect(last_response.body).to eq("Not an ajax request")
  end

  it "Update" do
    get '/update'
    expect(last_response.body).to eq("Not an ajax request")
  end

  it "Update HTTP_X_REQUESTED_WITH" do
    get '/update',{}, {"HTTP_X_REQUESTED_WITH" => "XMLHttpRequest"}
    expect(last_response).to be_ok
  end

  it "User" do
    get '/user'
    expect(last_response.body).to eq("<h1>Not Found</h1>")
  end


  it "chat update" do
    get '/chat/update'
    expect(last_response.body).to eq("<h1>Not Found</h1>")
  end

end
