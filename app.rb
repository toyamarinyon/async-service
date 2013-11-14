get '/' do
	slim :'views/index'
end

get '/manage' do
	slim :'views/manage'
end

get '/application.css' do
	sass(:"assets/sass/application", Compass.sass_engine_options )
end

get '/application.js' do
	coffee :'assets/coffee/application'
end
