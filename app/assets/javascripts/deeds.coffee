$(document).on 'turbolinks:load', ->
  $('#new_deed i').click (event) ->
    $('#trash_bag_instructions').toggle()
