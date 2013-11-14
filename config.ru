require 'rubygems'
require 'bundler'
Bundler.require
require './app.rb'

set :static, true
set :public_folder, File.dirname(__FILE__) + '/assets'
set :views, File.dirname(__FILE__) + '/templates'
run Sinatra::Application
