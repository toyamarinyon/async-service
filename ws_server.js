var io = require('socket.io').listen(10234);

io.sockets.on('connection', function (socket) {
	socket.emit('news', { hello: 'world' });
	socket.on('join', function (member) {
	    socket.broadcast.emit('auth', { name: member.name });
	});
	socket.on('send_question', function(question_data) {
	    socket.broadcast.emit('update_question', { question_data: question_data});
	});
	socket.on('exec_q1', function () {
	    socket.broadcast.emit('client_exec_q1');
	});
	socket.on('exec_q2', function () {
	    socket.broadcast.emit('client_exec_q2');
	});
	socket.on('exec_q3', function () {
	    socket.broadcast.emit('client_exec_q3');
	});
});
