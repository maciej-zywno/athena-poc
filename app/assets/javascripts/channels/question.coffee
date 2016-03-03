App.question = App.cable.subscriptions.create "QuestionChannel",
  collection: -> $("[data-channel='question']")

  connected: ->
    # FIXME: While we wait for cable subscriptions to always be finalized before sending messages
    setTimeout =>
      @followCurrentQuestion()
      @installPageChangeCallback()
    , 1000

  received: (data) ->
    @collection().append(data.answer)

  followCurrentQuestion: ->
    if questionId = @collection().data('question-id')
      @perform 'follow', question_id: questionId
    else
      @perform 'unfollow'

  installPageChangeCallback: ->
    unless @installedPageChangeCallback
      @installedPageChangeCallback = true
      $(document).on 'page:change', -> App.question.followCurrentQuestion()