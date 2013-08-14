jQuery ->
  $('.hint_tag_link').click ->
    tags_input = $(this).parent().prev()
    val = tags_input.val()
    val += ", " if val
    val += $(this).text()
    tags_input.val(val)
    return false