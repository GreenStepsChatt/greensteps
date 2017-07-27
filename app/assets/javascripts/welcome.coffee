$(document).on 'turbolinks:load', ->
  $('#sign_up').toggleClass 'active'

  $('#site_entry').on 'click', 'header', =>
    $(this).find('#sign_up, #log_in').toggleClass 'active'
