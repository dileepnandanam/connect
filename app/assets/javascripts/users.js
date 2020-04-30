$(document).on('turbolinks:load', function() {
  $(document).on('ajax:success', '.new_response', function(e) {
    $(this).replaceWith(e.detail[2].responseText)
  })
  $(document).on('ajax:error', '.new_response', function(e) {
    $(this).replaceWith(e.detail[2].responseText)
  })

  $(document).on('ajax:success', '.user-action', function(e) {
    $(this).closest('.user').html("You have found your spouse. start chating <a href='/chats'> here </a>")
  })

  search = function(gender) {
    query = $('.search').val()
    $.ajax({
      url: 'users/search',
      method: 'GET',
      data: {
        query: query,
        gender: gender
      }, success: function(data) {
        $('.users').replaceWith(data)
      }
    })
  }

  $('.search-male').click(function(e) {
    search('male')
    e.preventDefault()
  })
  $('.search-female').click(function(e) {
    search('female')
    e.preventDefault()
  })
  $('.search-others').click(function(e) {
    search('other')
    e.preventDefault()
  })
})