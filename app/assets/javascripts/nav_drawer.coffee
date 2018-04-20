class Greensteps.NavDrawer
  constructor: (@drawerSelector, @drawerTogglerSelector, @shouldCollapse) ->
    @drawer = $(@drawerSelector)
    # once we can use :backdrop, we should automatically include the pseudo
    # element in @drawerToggler so that users aren't required to specify it in
    # @drawerTogglerSelector like they currently are with the drawer container
    @drawerToggler = $(@drawerTogglerSelector)
    @overlay = @drawer.parent()

    # This can be much simpler once we can use the :backdrop pseudo element. We
    # All we'll have to do here is toggle the drawer, I think that the backdrop
    # will just become visible once the drawer is. We'll need to add a click
    # event for the drawer's :backdrop pseudo element so that a click on it
    # still triggers the drawer to close. Not sure how we'd do the fading effect
    # for the overlay/backdrop, but we'll just have to see what happens when we
    # only toggle the drawer with slide effect.
    @drawerToggler.on 'click', (e) =>
      e.preventDefault()
      this.toggleDrawer()

    @overlay.on 'click', (e) =>
      this.toggleDrawer()

    @overlay.children().on 'click', (e) ->
      e.stopPropagation()

    $(window).resize =>
      this.setVisibility()

    # wait to set visibility until after event handlers are attached
    this.setVisibility()

  setVisibility: =>
    if this.shouldCollapse()
      @drawerToggler.show()
      this.hideDrawer() if @drawer.is(':visible')
    else
      @drawerToggler.hide()
      this.showDrawer() unless @drawer.is(':visible')

  toggleDrawer: =>
    if @drawer.is(':visible')
      this.hideDrawer()
    else
      this.showDrawer()

  showDrawer: =>
    @overlay.show 'fade', 'fast', =>
      @drawer.show 'slide', {direction: 'right'}

  hideDrawer: =>
    @drawer.hide 'slide', {direction: 'right'}, =>
      @overlay.hide 'fade', 'fast'

  isStale: ->
    !document.body.contains(@drawer[0])
