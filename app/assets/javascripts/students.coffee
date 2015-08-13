$ ->
  showFlash = (data) ->
    $flash = $('body')
      .prepend "<div class='flash #{data.status}'>#{data.status_text}</div>"
      .children '.flash'
    setTimeout(
      ->
        $flash.remove()
      , 3000
    )

  $('body')
    .on 'ajax:success', (e, data) ->
      showFlash data
      # if e.target.id is 'new_student' and e.target.nodeName is 'FORM'
