$(document).on 'turbolinks:load', ->
  $('input[type="number"]').each ->
    input = $(this)
    nav = input.next('.quantity-nav')
    btns = nav.find('.quantity-button')
    min = input.attr('min') || 0
    max = input.attr('max') || Infinity
    btns.each ->
      this.addEventListener 'click', (event) ->
        operator = event.target.innerHTML
        oldVal = parseFloat(input.val())
        newVal = oldVal
        switch operator
          when '+'
            if oldVal < max
              newVal = oldVal + 1
          when '-'
            if oldVal > min
              newVal = oldVal - 1
        input.val newVal
        input.trigger 'change'
        return
    return
