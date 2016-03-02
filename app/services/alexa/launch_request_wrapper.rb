class Alexa::LaunchRequestWrapper < Alexa::RequestWrapper

  def process
    question_id_and_questions_pairs = get_question_id_and_questions_pairs
    next_question = question_id_and_questions_pairs[0]
    session_attributes = {
        'questions' => question_id_and_questions_pairs,
        'answered_questions' => [],
        'current_question' => next_question
    }

    [next_question[1], session_attributes, false]
  end

end