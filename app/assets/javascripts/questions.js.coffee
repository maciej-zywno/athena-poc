$ ->
  hide_threshold_inputs = ->
    $('.question_high_threshold').hide()
    $('#question_high_threshold').val('')
    $('.question_low_threshold').hide()
    $('#question_low_threshold').val('')
    $('.question_risky_keywords').show()

  hide_risky_keyword_input = ->
    $('.question_high_threshold').show()
    $('.question_low_threshold').show()
    $('.question_risky_keywords').hide()
    $('#question_risky_keywords').val('')

  update_form = ->
    if $('#question_answer_type option:selected').attr('value') == 'string'
      hide_threshold_inputs()
    else
      hide_risky_keyword_input()

  update_form()

  $('#question_answer_type').change ->
    update_form()