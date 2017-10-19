$(document).on 'turbolinks:load', ->
  $('input[type="number"]').each ->
    input = $(this)
    nav = input.next('.quantity-nav')
    btns = nav.find('.quantity-button')
    min = input.attr('min')
    max = input.attr('max')
    btns.each ->
      this.addEventListener 'click', (event) =>
        operator = event.target.innerHTML
        oldValue = parseFloat(input.val())
        if oldValue >= max && operator == '+' || oldValue <= min && operator == '-'
          newVal = oldValue
        else
          newVal = eval(oldValue + operator + 1)
        input.val newVal
        input.trigger 'change'
        return
    return
