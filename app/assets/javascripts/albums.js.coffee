jQuery ->
  page = 1

  goToNextPage = ->
    $.ajax
      url: window.location + "?page=#{++page}"
      method: 'get'
      success: (html) ->
        $('#albums_container').append(html)
        remix.heightSlideBlockLinks(container:$('#albums_container'))
        remix.magnificPopupGalleryOnPage({container:$('#albums_container')});
      error: (xhr, status, error) ->
        if xhr.status==404
        	$('.ph-showmore').hide()
  $('.ph-showmore-btn').click(goToNextPage)