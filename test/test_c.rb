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

describe "Capybara and selenium tests" do
    before (:all) do
	driver=Capybara.current_driver = :selenium
	@site='localhost:9292'
	@site1='http://practicachatsytw.herokuapp.com'
    end
    
    it "log anonymous" do
      Capybara.visit(@site)
      Capybara.click_button('anonimo')
      Capybara.fill_in 'text', :with => 'Prueba'
    end
    
    it "log with nick" do
      Capybara.visit(@site)
      Capybara.fill_in 'nickname', :with => 'Test'
      Capybara.click_button('entrar')
    end
    
    it "register" do
      Capybara.visit(@site)
      Capybara.click_link('registro')
    end
    
    it "posting" do
    end
    
    after(:all) do
      Capybara.use_default_driver
    end
    
end
