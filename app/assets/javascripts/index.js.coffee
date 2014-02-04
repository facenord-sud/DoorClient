$ ->
  $("a[use_url]").click ->
    $('#door_uri').val($(this).attr('use_url'))
  $('.show-door').click ->
    history.pushState('', null, this.href)
$ ->
  $('#lock_state').change ->
    val = $('#lock_state').val()
    return if val == ''
    $('#new_lock').submit()
$ ->
  $('#open_state').change ->
    val = $('#open_state').val()
    return if val == ''
    $('#new_open').submit()

