$(document).on 'turbolinks:load', ->
  $('.prizes form').on 'click', 'label', ->
    label = $(event.target)
    radio_button = label.prev()
    radio_button.prop('checked', true)
    label.closest('.prizes form').submit()
