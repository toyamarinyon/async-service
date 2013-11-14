var io = require('socket.io').listen(10234);

io.sockets.on('connection', function (socket) {
	socket.emit('news', { hello: 'world' });
	socket.on('join', function (member) {
	    socket.broadcast.emit('auth', { name: member.name });
	});
});
