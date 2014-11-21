# -*- coding: utf-8 -*-

ENV['RACK_ENV'] = 'test'
require_relative '../chat.rb'
require 'test/unit'
require 'minitest/autorun'
require 'rack/test'
require 'coveralls'

Coveralls.wear!


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
		@css="/public/css/groundwork.css"
		@js="/public/js/chat.js"
	end
it "Crea nuevo link" do
		prueba=User.new(:nickname => "Prueba")
		assert (prueba.save)
	end

	it "Borra el link" do
		prueba=User.first(:nickname => "Prueba")
		assert(prueba.destroy)
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

	it "Comprueba si esta el CSS en el servidor" do

		path = File.absolute_path(__FILE__)
		path=path+@css
		path=path.split('/test/test_u.rb')
		path=path[0]+path[1]

		assert File.exists?(path), "Debe estar el CSS en el servidor"
	end

	it "Comprueba si esta el Javascript en el servidor" do

		path = File.absolute_path(__FILE__)
		path=path+@js
		path=path.split('/test/test_u.rb')
		path=path[0]+path[1]

		assert File.exists?(path), "Debe estar el Javascript en el servidor"
	end

end

describe "Test para datamapper" do

	it "Crea nuevo link" do
		prueba=User.new(:nickname => "Prueba")
		assert (prueba.save)
	end

	it "Borra el link" do
		prueba=User.first(:nickname => "Prueba")
		assert(prueba.destroy)
	end
end
