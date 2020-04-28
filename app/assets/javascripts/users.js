$(document).on('turbolinks:load', function() {
  $(document).on('ajax:success', '.new_response', function(e) {
    $(this).closest('.user').remove()
  })

  $(document).on('ajax:success', '.user-action', function(e) {
    $(this).closest('.user').html("You have found your spouse. start chating <a href='/chats'> here </a>")
  })
})