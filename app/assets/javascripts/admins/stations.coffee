$(document).on 'turbolinks:load', ->
  $('#address_or_coordinates_toggler').on 'click', ->
    $(document).find('#street_address_fields, #coordinate_fields').toggle()
