require.config
  paths:
    jquery: '/vendor/bower/jquery/jquery'
    underscore: '/vendor/bower/underscore-amd/underscore'
    backbone: '/vendor/bower/backbone-amd/backbone'
require ['jquery','backbone','underscore'], ($,b,_) ->
  $ ->

    think_start_time = 0

    $('#q1_answer').on 'click', ->
      $('#ac2').attr 'id', 'r'
    $('#q2_answer').on 'click', ->
      $('#ac4').attr 'id', 'r'

    # 回答ページへ遷移 {{{
    $('#join').on 'click', ->
      $('#form').submit()
      
    # 回答ページへ遷移 }}}
    
    # 正解を点滅 {{{ 
    blink_interval_sec = 0.8
    setInterval ->
      $('#r').toggleClass('right')
    , blink_interval_sec * 1000
    # 正解を点滅 }}}

    # 正解者を表示 {{{
    $($('ul.right_answer li').get().reverse()).each (i,element) ->
      $(element).css 'opacity', 0
      $(element).delay(i*400).animate({opacity: 1},500)
    # 正解者を表示 }}}

    # 正解を送信 {{{
    $('#answer_submit').on 'click', ->
      question_no = $('#q').data 'questionNo'
      answer_no = $('input[name="answer_choice"]:checked').val()
      thinking_ms = +new Date() - think_start_time
      $.ajax {
        type: 'POST'
        url: '/api/send_answer'
        data: {
          question_no: question_no
          answer_no: answer_no
          thinking_ms: thinking_ms
        }
        success: (res) ->
          # console.log respose
          alert res.answer_no + ' を送信しました。'
      }
    # 正解を送信 }}}

    # websocket {{{ 
    socket = io.connect 'http://192.168.50.32:10234'
    socket.on 'news', (data) ->
      console.log data
    socket.on 'auth', (data) ->
      console.log data
      $('.manage-set').append $('<div />').addClass('user').append data.name
    socket.on 'client_exec_q1', ->
     $('#q').data('questionNo', 1).text('問題：効果ナビゲーター(の親戚の)藤田の出身地はどこ？')
     think_start_time = +new Date()
    socket.on 'client_exec_q2', ->
     $('#q').data('questionNo', 2).text('問題：効果ナビゲーターの正式名称は？')
     think_start_time = +new Date()
    socket.on 'client_exec_q3', ->
     $('#q').data('questionNo', 3).text('問題：効果ナビゲーターの週末といえば！')
     think_start_time = +new Date()
    $('#join').on 'click', ->
      socket.emit 'join', { name: $('#login_name').val() }
    # websocket }}}
    
    # emitter {{{
    if $('#emitter').length > 0
      emit_type  = $('#emitter').data('emitType')
      emit_value = $('#emitter').data('emitValue')
      if emit_type == 'question' and  emit_value == 1
        socket.emit 'exec_q1'
      if emit_type == 'question' and  emit_value == 2
        socket.emit 'exec_q2'
      if emit_type == 'question' and  emit_value == 3
        socket.emit 'exec_q3'
    # emitter }}}
