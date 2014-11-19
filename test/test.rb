# -*- coding: utf-8 -*-

ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'selenium-webdriver'
require 'capybara'


include Rack::Test::Methods

def app
  Sinatra::Application
end

describe "Tests de la pagina raiz principal ('/') con metodo get" do
	before :all do
		@imagen="/public/logo/logo.png"
		@textoTitulo="<title>Practica Chat</title>"
		@textoCabecera="Chat"
		@textoContenido="Acorta tu URL"
		@css="/public/css/groundworks.css"
	end

	it "Carga de la web desde el servidor" do
	  get '/'
	  assert last_response.ok?
	end
	it "Comprueba el titulo de la pagina" do
		get '/'
		assert last_response.body.include?(@textoTitulo), "El titulo tiene que ser: "+@textoTitulo
	end

	it "Comprueba que en la pagina hay una cabecera" do

		get '/'
		assert last_response.body.include?(@textoCabecera), "El titulo de cabecera tiene que estar en el contenido"

	end

end

describe "Capybara and selenium tests" do
    before (:all) do
	driver=Capybara.current_driver = :selenium
    end
    
    it "log anonymous" do
      Capybara.visit('localhost:9292')
      Capybara.click_button('anonimo')
    end
    
    it "log with nick" do
      Capybara.visit('localhost:9292')
      Capybara.fill_in 'nickname', :with => 'Test'
      Capybara.click_button('entrar')
    end
    
    it "posting" do
    end
    
    after(:all) do
      Capybara.use_default_driver
    end
    
end
