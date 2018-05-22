$(document).on 'turbolinks:load', ->
  $('#address_or_coordinates_toggler').on 'click', ->
    $(document).find('#street_address_fields, #coordinate_fields').toggle()

  $('form[action="/admins/stations"]').on 'submit', (event) ->
    form = $(event.target)
    inactiveFieldset = form.find('fieldset:hidden')
    inactiveFieldset.remove()
