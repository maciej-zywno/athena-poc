class Alexa::IntentRequestWrapper < Alexa::RequestWrapper

  def process
    # add current answer to answered_questions
    current_answered_questions = get_session_answered_questions
    current_question_id, current_question_text = get_session_current_question
    current_question_answer = get_request_answer_value

    store(current_question_id, current_question_answer)

    new_answered_questions = current_answered_questions << [current_question_id, current_question_answer]

    all_questions_answered = all_questions_answered?(get_session_questions,
                                                     get_session_answered_questions)
    Rails.logger.info "ALL_QUESTIONS_ANSWERED=#{all_questions_answered}"

    if all_questions_answered
      ['Thank you. Your answers have been recorded.', {}, true]
    else
      next_question = any_not_answered_question(get_session_questions,
                                                get_session_answered_questions)
      session_attributes = {
          'current_question' => next_question,
          'answered_questions' => new_answered_questions,
          'questions' => get_question_id_and_questions_pairs
      }

      [next_question[1], session_attributes, false]
    end
  end

  private

    def store(question_id, answer)
      Rails.logger.info "Create answer #{question_id}"
      answer = Answer.create!(question_id: question_id, answer: answer)
      ProcessAnswerService.new.call(answer)
      QuestionBroadcastJob.perform_later(answer.question)
    end

    # all_questions: [[4, "On a scale 1 to 10 how bad is your back today?"], [1, "How do you feel today?"]]
    # answered_questions: [[1, "foo"], [4, "bar"]]
    def all_questions_answered?(all_questions, answered_questions)
      Rails.logger.info "!!! ALL_QUESTIONS_ANSWERED? !!!"
      Rails.logger.info "all_questions=#{all_questions.inspect}"
      Rails.logger.info "answered_questions=#{answered_questions.inspect}"
      all_questions.length == answered_questions.length
    end

    def any_not_answered_question(all_questions, answered_questions)
      answered_ids = answered_questions.map(&:first)
      Rails.logger.info "ANSWERED_IDS=#{answered_ids}"
      Rails.logger.info "ANSWERED_QUESTIONS=#{answered_questions.inspect}"
      not_answered_question = all_questions.find{|e|
        !answered_ids.include?(e[0])
      }
      Rails.logger.info "NOT_ANSWERED_QUESTION=#{not_answered_question.inspect}"
      not_answered_question
    end

end