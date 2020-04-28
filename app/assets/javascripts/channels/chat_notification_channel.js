notification_subscribed = null
$(document).on('turbolinks:load', function() {
  audio = new Audio($('.response-notif').attr('src'));
  
  if(notification_subscribed == null) {
    App.cable.subscriptions.create("ApplicationCable::ChatNotificationsChannel", {
      received(data) {
        audio.play()
        $('.chat-thread').append(data.message)
      }
    })
    notification_subscribed = 1
  }
})