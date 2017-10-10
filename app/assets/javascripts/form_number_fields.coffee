$(document).on 'turbolinks:load', ->
  $('input[type="number"]').each ->
    input = $(this)
    $('<div class="quantity-nav">
      <div class="quantity-button quantity-up">+</div>
      <div class="quantity-button quantity-down">-</div></div>')
        .insertAfter(input)
    nav = input.next('.quantity-nav')
    btnUp = nav.find('.quantity-up')
    btnDown = nav.find('.quantity-down')
    min = input.attr('min')
    max = input.attr('max')
    btnUp.click ->
      oldValue = parseFloat(input.val())
      if oldValue >= max
        newVal = oldValue
      else
        newVal = oldValue + 1
      input.val newVal
      input.trigger 'change'
      return
    btnDown.click ->
      oldValue = parseFloat(input.val())
      if oldValue <= min
        newVal = oldValue
      else
        newVal = oldValue - 1
      input.val newVal
      input.trigger 'change'
      return
    return
