# For now just assume that the element to be dismissed is the parent of the
# dismiss button. Later we could add a parameter to remove this assumption, but
# we'd need to be careful that each button only hides it's own corresponding
# element.
class Greensteps.Dismissable
  constructor: (@dismisserSelector) ->
    @dismisser = $(@dismisserSelector)
    @toBeDismissed = @dismisser.parent()

    @dismisser.on 'click', =>
      @toBeDismissed.slideUp().hide()
