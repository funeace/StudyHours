document.addEventListener 'turbolinks:load', ->
  # 配信先を決定する処理
  App.room = App.cable.subscriptions.create {channel: "RoomChannel",room: $('#chats').data('room_id')},
    connected: ->
    # Called when the subscription is ready for use on the server

    disconnected: ->
    # Called when the subscription has been terminated by the server

    received: (data) ->
      # 受け取ったデータをチャット欄に追記する処理
      $('#chats').append $(data['chat'])
      current_user_id = $('#chats').data('user_id')
      chat_user_id = $('.chat:last-child').data('chat_user_id')
      if (current_user_id == chat_user_id)
        $('.chat:last-child').addClass('self')
      else
        $('.chat:last-child').addClass('other')

    speak: (chat) ->
      @perform 'speak', chat: chat

  

  # Enterを押下したタイミングでデータが送信される処理
  $('#chat-input').on 'keypress', (event) ->
    if event.keyCode is 13
      App.room.speak event.target.value
      event.target.value = ''
      event.preventDefault()