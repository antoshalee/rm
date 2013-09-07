jQuery ->
  console.log($('#check_card_form'))
  $('#check_card_form').on 'ajax:success', (xhr, data) ->
    $('#check_card_result').text(data.message)
