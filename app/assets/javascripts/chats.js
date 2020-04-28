$(document).on('turbolinks:load', function() {
  bind_chat = function() {
    $(document).on('ajax:success', '.chat-box', function(e) {
      $(document).off('ajax:success', '.chat-box')
      $('.chat-thread').append(e.detail[2].responseText)
      bind_chat()
    })
  }
  bind_chat()
})