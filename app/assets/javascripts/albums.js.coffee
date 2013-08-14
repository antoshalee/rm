jQuery ->
  page = 1

  goToNextPage = ->
    $.get window.location + "?page=#{++page}", (html) ->
      $('#albums_container').append(html)
      remix.heightSlideBlockLinks(container:$('#albums_container'))

  $('.ph-showmore-btn').click(goToNextPage)