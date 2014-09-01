$ ->
  $(document).on('change', '#lock_state', ->
    val = $('#lock_state').val()
    return if val == ''
    $('#new_lock').submit()
  )
$ ->
  $(document).on('change', '#open_state', ->
    val = $('#open_state').val()
    return if val == ''
    $('#new_open').submit()
  )

