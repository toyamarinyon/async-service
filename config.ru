require 'rubygems'
require 'bundler'
Bundler.require
require './app.rb'
require './connection.rb'

enable :static, :sessions
set :public_folder, File.dirname(__FILE__) + '/assets'
set :views, File.dirname(__FILE__) + '/templates'
run Sinatra::Application
