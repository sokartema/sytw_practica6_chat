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

describe "Login testing" do
  
	before :all do
	  @browser=Selenium::WebDriver.for :firefox
	  @site='http://practicachatsytw.herokuapp.com'
	  if (ARGV[0].to_s == "local")
	    @site='localhost:9292'
	  end

	end

	it "login anonymous" do

		@browser.get(@site)
		@browser.manage.timeouts.implicit_wait=3
		element=@browser.find_element :id => "anonimo"
		element.click
		@browser.manage.timeouts.implicit_wait=3

		body_element = @browser.find_element(:tag_name => "body")
		body_element=body_element.text.to_s
		
		value=false
		if body_element.include? "Send"
			value=true
		end
		assert (not(value))

	end
		it "posting anonymous" do
	  
		@browser.get(@site)
		@browser.manage.timeouts.implicit_wait=3
		element=@browser.find_element :id => "anonimo"
		element.click
		@browser.manage.timeouts.implicit_wait=3
		body_element=@browser.find_element(:id =>"text").send_keys("testing")
		
		#body_element.send_keys(Keys.RETURN)
		body_element=body_element.text.to_s
		
		value=false
		if body_element.include? "testing"
			value=true
		end
		assert(value)
		@browser.close()
		
	end

end

