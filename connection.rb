require 'sinatra/activerecord'
require 'sinatra/activerecord/rake'

ActiveRecord::Base.establish_connection(
	adapter: 'sqlite3',
	database: 'development.db'
)
