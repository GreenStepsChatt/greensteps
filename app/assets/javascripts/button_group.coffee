class Greensteps.RadioButtonGroup
  constructor: (@wrapperSelector) ->
    @wrapper = $(@wrapperSelector)

    @wrapper.on 'click', 'button', (event) =>
      @wrapper.find('.selected').removeClass('selected')
      $(event.target).addClass('selected')
