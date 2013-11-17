var io = require('socket.io').listen(10234);

io.sockets.on('connection', function (socket) {
	socket.emit('news', { hello: 'world' });
	socket.on('join', function (member) {
	    socket.broadcast.emit('auth', { name: member.name });
	});
	socket.on('exec_q1', function () {
	    socket.broadcast.emit('client_exec_q1');
	});
});
