$(document).on 'turbolinks:load', ->
  $('.prizes form').on 'click', 'label', ->
    label = $(event.target)
    label.prev().prop('checked', true)
    label.closest('.prizes form').submit()
