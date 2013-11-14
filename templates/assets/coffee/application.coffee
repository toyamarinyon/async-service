require.config
  paths:
    jquery: '/vendor/bower/jquery/jquery'
    underscore: '/vendor/bower/underscore-amd/underscore'
    backbone: '/vendor/bower/backbone-amd/backbone'
require ['jquery','backbone','underscore'], ($,b,_) ->
  $ ->
    socket = io.connect 'http://localhost:10234'
    socket.on 'news', (data) ->
      console.log data
    socket.on 'auth', (data) ->
      console.log data
      $('.manage-set').append $('<div />').addClass('user').append data.name
    $('#join').on 'click', ->
      socket.emit 'join', { name: $('#login_name').val() }
      return false
 
    # ws = new WebSocket 'ws://localhost:8888'
    # output = $('#output')
    # input = $('#input')

    # print = (event_name, message) ->
    #   $('<div />').append event_name+' : '+message

    # input.on 'click', ->
    #   message = $('#message').val
    #   ws.send message
    #   output.append(print 'send', message )

    # ws.onmessage = (event) ->
    #   output.append(print 'recieved', event.data)

    # ws.onclose = (event) ->
    #   output.append(print 'closed', event.data)
