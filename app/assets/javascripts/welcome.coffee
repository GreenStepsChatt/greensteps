$(document).on 'turbolinks:load', ->
  $('#site_entry').on 'click', 'header', =>
    $(this).find('#sign_up, #log_in').toggleClass 'active'
