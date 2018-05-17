$(document).on 'turbolinks:load', ->
  $('.prizes form').on 'click', 'button', ->
    label = $(event.target).closest('label')
    radio = label.prev()
    form = label.closest('.prizes form')

    radio.prop('checked', true) # make sure there's no race condition
    form.submit()
