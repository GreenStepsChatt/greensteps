window.Greensteps ||= {}

Greensteps.init = ->
  @navDrawer = new Greensteps.NavDrawer(
    '#nav_drawer',
    '.menu_toggler',
    -> true
  )
  new Greensteps.Dismissable('.flash-message button')

$(document).ready ->
  Greensteps.init()

$(document).on 'turbolinks:load', ->
  new Greensteps.Dismissable('.flash-message button')

  if Greensteps.navDrawer.isStale()
    Greensteps.navDrawer = new Greensteps.NavDrawer(
      '#nav_drawer',
      '.menu_toggler',
      -> true
    )
