jQuery ->
  $("a[rel~=popover], .has-popover").popover()
  $("a[rel~=tooltip], .has-tooltip").tooltip()
  # $('.collapse').collapse('hide')

  # TRIGGER ACTIVE STATE
  $('#mobnav-btn').click ->
    $('.sf-menu').toggleClass("xactive")

  # TRIGGER DROP DOWN SUBS
  $('.mobnav-subarrow').click ->
    $(this).parent().toggleClass("xpopdrop")
