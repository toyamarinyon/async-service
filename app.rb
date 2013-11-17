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
	answer_no = params[:answer_no]
	Answer.create(
		:user_id => uid,
		:question_no => question_no,
		:answer_no => answer_no,
		:answer_time => '00:01'
	)

	content_type :json
	data =  {
		'user_id'     => uid,
		'question_no' => question_no,
		'answer_no'   => answer_no,
		'answer_time' => '00:01'
	}

	data.to_json
end

get '/q1' do
	slim :'views/q1'
end

get '/a1' do
	@answers = Answer.where(:question_no => 1, :answer_no => 2)
	# @answers = User.where(:id => 1 )
	# @answers.to_json
	slim :'views/a1'
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
