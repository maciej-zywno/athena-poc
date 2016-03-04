App.question = App.cable.subscriptions.create "QuestionChannel",
  collection: -> $("[data-channel='question']")

  connected: ->
    setTimeout =>
      @followCurrentQuestion()
      @installPageChangeCallback()
    , 1000

  received: (data) ->
    @collection().html(data.question_data)

  followCurrentQuestion: ->
    if questionId = @collection().data('question-id')
      @perform 'follow', question_id: questionId
    else
      @perform 'unfollow'

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'page:change', -> App.question.followCurrentQuestion()
