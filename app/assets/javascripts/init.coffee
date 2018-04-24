window.Greensteps ||= {}

Greensteps.init = ->
  @navDrawer = new Greensteps.NavDrawer(
    '#nav_drawer',
    '.menu_toggler',
    -> true
  )
  new Greensteps.Dismissable('.flash-message button')
  new Greensteps.Dismissable('#map_info button')
  new Greensteps.RadioButtonGroup('#address_or_coordinates_toggler')

$(document).ready ->
  Greensteps.init()

$(document).on 'turbolinks:load', ->
  new Greensteps.Dismissable('.flash-message button')
  new Greensteps.Dismissable('#map_info button')
  new Greensteps.RadioButtonGroup('#address_or_coordinates_toggler')

  if Greensteps.navDrawer.isStale()
    Greensteps.navDrawer = new Greensteps.NavDrawer(
      '#nav_drawer',
      '.menu_toggler',
      -> true
    )
