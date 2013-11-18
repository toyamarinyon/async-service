class User < ActiveRecord::Base
	has_many :answers
end
class Answer < ActiveRecord::Base
	belongs_to :user
end

get '/' do
	slim :'views/index'
end

post '/join' do
	User.where(:name => params[:login_name]).first_or_create
	session['uid'] = User.where(:name => params[:login_name]).first.id.to_s
	redirect '/r'
end

get '/r' do
	slim :'views/r'
end

post '/api/send_answer' do
	uid = session['uid']
	question_no = params[:question_no]
	answer_no   = params[:answer_no]
	thinking_ms = params[:thinking_ms]
	answer = Answer.where(:user_id => uid, :question_no => question_no).first_or_create do |table|
		table.answer_no   = answer_no
		table.thinking_ms = thinking_ms
	end

	answer.update_attributes(:answer_no => answer_no, :thinking_ms => thinking_ms)

	content_type :json
	data =  {
		'user_id'     => uid,
		'question_no' => question_no,
		'answer_no'   => answer_no,
		'answer_time' => thinking_ms
	}

	data.to_json
end

get '/q1' do
	slim :'views/q1'
end

get '/q2' do
	slim :'views/q2'
end

get '/q3' do
	slim :'views/q3'
end

get '/a1' do
	@answers = Answer.where(:question_no => 1, :answer_no => 2).order('thinking_ms')
	slim :'views/a1'
end

get '/a2' do
	@answers = Answer.where(:question_no => 2, :answer_no => 4).order('thinking_ms')
	slim :'views/a2'
end

get '/a3' do
	@answers = Answer.where(:question_no => 3, :answer_no => 3).order('thinking_ms')
	slim :'views/a3'
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
