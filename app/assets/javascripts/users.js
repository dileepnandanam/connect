initMasonry = function() {
  $('.users').imagesLoaded(function() {
    $('.users').masonry({
      itemSelector: '.user',
      gutter: 100
    })
  })
}

$(document).on('turbolinks:load', function() {
  initMasonry()
  $(document).on('ajax:success', '.new_response', function(e) {
    $(this).replaceWith(e.detail[2].responseText)
  })
  $(document).on('ajax:error', '.new_response', function(e) {
    $(this).replaceWith(e.detail[2].responseText)
  })

  $(document).on('ajax:success', '.user-action', function(e) {
    $(this).siblings('.response-content').html(e.detail[2].responseText)
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
        initMasonry()
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

  $('.unsigned').click(function(e) {
    window.location.href = '/logins/new'
  })
})